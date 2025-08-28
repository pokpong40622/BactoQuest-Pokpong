import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bacto_quest/pages/checking_page.dart';
import 'package:bacto_quest/pages/summary_page.dart';
import 'package:bacto_quest/services/KeaneData.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrushingPage extends StatefulWidget {
  const BrushingPage({super.key});

  @override
  State<BrushingPage> createState() => _BrushingPageState();
}

class _BrushingPageState extends State<BrushingPage> {
  List<bool> toothList = [];
  Random random = Random(42);
  var state = 0;
  var imgState = 0;
  var start = 5;
  var countDownController = CountDownController();
  var clickState = false;

  late var timer;

  Future<void> startTimer() async {
    timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (start == 0) {
        start = 9;
        
        if (imgState < 5) {
          setState(() {
            imgState += 1;
          });
        }
        if (imgState >= 5 && state == 1) {
          print("Hello");
          setState(() {
            imgState = 0;
            state = 0;
          });
          for (int i = 0; i < 32; i++) {
            bool toothState = random.nextBool();
            toothList.add(toothState) ;
          }


          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckingPage()));
        }
      } 
      else {
        setState(() {
          start--;
        });
      }
    });
  }

  String getStepImage(int step) {
    String imagePath = "assets/step1.png";

    if (imgState == 0) {
      imagePath = "assets/hod.png";
    }
    if (imgState == 1) {
      imagePath = "assets/Step2.png";
    }
    if (imgState == 2) {
      imagePath = "assets/Step3.png";
    }
    if (imgState == 3) {
      imagePath = "assets/Step4.png";
    }
    if (imgState == 4) {
      imagePath = "assets/Step5.png";
    }
    if (imgState == 5) {
      imagePath = "assets/Step6.png";
    }

    return imagePath;
  }

  List<String> brushingStep = [
    "Squeeze the Toothpaste!",
    "Brush the Front!",
    "Twirl the Brush!",
    "Brush the Back!",
    "In & out!",
    "Brush Your Tongue!"
  ];

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset("assets/logo.png"),
        title: Text("Tooth Brushing", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            state = 1;
          });
          if (!clickState) {
            clickState = true;
            startTimer();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (state == 0) ...[
            SizedBox(width: double.infinity, height: 20),
            Image.asset("assets/brushing.png", width: 275),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              decoration: BoxDecoration(
                color: ColorsAsset.primary,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text("Click anywhere to start brushing!!", style: GoogleFonts.dmSans(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            )]
            else if (state == 1) ...[
              Column(
                children: [
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(child: CircularCountDownTimer(width: 255, height: 265, duration: start + 1, controller: countDownController, initialDuration: 0,fillColor: Colors.white, ringColor: ColorsAsset.primary, isTimerTextShown: false, isReverse: true, strokeWidth: 10,
                          onComplete: () {
                            setState(() {
                              countDownController.restart();
                            });
                          },
                          )),
                          Image.asset(
                            getStepImage(imgState)
                            ,width: 250),
                        ],
                      ),

                      SizedBox(width: 50),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 250, child: Text(brushingStep[imgState], style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black), textAlign: TextAlign.center,)),
                          SizedBox(width: 250, child: Text("${start}s", style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 70, color: ColorsAsset.green), textAlign: TextAlign.center,)),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}