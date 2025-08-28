import 'dart:convert';

import 'package:bacto_quest/services/KeaneData.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
        leading: Image.asset("assets/logo.png"),
        actions: [Icon(Icons.notifications, color: Colors.black, size: 30), SizedBox(width: 20)],
      ),
      body: GestureDetector(
        onTap: () async {
          await context.read<KeaneData>().writeCharacteristic!.write(utf8.encode("B-1"));
        },
        child: Column(
          children: [
            SizedBox(height: 20),
            // eyes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 360,
                  decoration: BoxDecoration(
                    color: ColorsAsset.primary,
                    borderRadius: BorderRadius.circular(24)
                  ),
                ),
                SizedBox(width: 230),
                Container(
                  width: 250,
                  height: 360,
                  decoration: BoxDecoration(
                    color: ColorsAsset.primary,
                    borderRadius: BorderRadius.circular(24)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}