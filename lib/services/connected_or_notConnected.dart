import 'package:bacto_quest/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectedOrNotConnected extends StatelessWidget {
  const ConnectedOrNotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterBluePlus.events.onConnectionStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.connectionState ==
              BluetoothConnectionState.connected) {
            return Navigation(
              connected: true,
            );
          }
          return Navigation(connected: false);
        } else if (snapshot.hasError) {
          return Text(
            "error: ${snapshot.error}",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          );
        } else {
          return Navigation(
            connected: false,
          );
        }
      },
    );
  }
}