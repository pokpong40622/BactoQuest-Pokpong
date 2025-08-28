import "package:bacto_quest/firebase_options.dart";
import "package:bacto_quest/pages/checking_page.dart";
import "package:bacto_quest/services/KeaneData.dart";
import "package:bacto_quest/services/connected_or_notConnected.dart";
import "package:camera/camera.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeaneData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConnectedOrNotConnected(),
      ));
    
  }
}