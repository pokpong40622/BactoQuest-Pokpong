import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Note: Ensure you have added `webview_flutter: ^4.7.0` to your pubspec.yaml

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  // Controller for the WebView, which will run our AI model.
  late final WebViewController _controller;
  
  // This state variable will hold the latest prediction from the AI model.
  String _prediction = "Initializing...";
  
  @override
  void initState() {
    super.initState();
    
    _controller = WebViewController()
      // This is crucial to allow the TensorFlow.js model to run.
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      // This sets up the communication channel from the WebView (JavaScript) to Flutter (Dart).
      // The name 'PredictionHandler' MUST match the name used in the HTML file.
      ..addJavaScriptChannel(
        'PredictionHandler', 
        onMessageReceived: (JavaScriptMessage message) {
          // When a new prediction is received from the JavaScript, update the state.
          if (mounted) {
            setState(() {
              _prediction = message.message;
            });
          }
        },
      )
      // Load the local HTML file from your project's assets folder.
      ..loadFlutterAsset('assets/ai_camera.html');
  }

  /// Helper function to return an appropriate icon based on the AI's prediction string.
  IconData _getIconForPrediction(String prediction) {
    switch (prediction.toLowerCase().trim()) {
      case 'smile':
        return Icons.sentiment_very_satisfied;
      case 'look up':
        return Icons.arrow_upward;
      case 'look left':
        return Icons.arrow_back;
      case 'look right':
        return Icons.arrow_forward;
      case 'look down':
        return Icons.arrow_downward;
      default: // Handles "Neutral" or any other class.
        return Icons.person; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT PANE: Displays the current prediction text and icon.
          SizedBox(
            width: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _prediction, // Display the live prediction from the state.
                  style: GoogleFonts.dmSans(fontSize: 40, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Icon(_getIconForPrediction(_prediction), size: 70),
              ],
            ),
          ),
          
          const SizedBox(width: 100),

          // RIGHT PANE: The WebView running the camera and AI model.
          Container(
            width: 600,
            height: 400,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black, // A background color while the view loads.
            ),
            child: WebViewWidget(controller: _controller),
          )
        ],
      ),
    );
  }
}