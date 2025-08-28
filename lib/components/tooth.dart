import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tooth extends StatelessWidget {
  Tooth({super.key, required this.toothNumber, required this.toothState});

  int toothNumber;
  bool toothState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(toothNumber.toString() + ": ", style: GoogleFonts.dmSans(fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black)),
          ),
          
          SizedBox(
            width: 110,
            child: Text(toothState ? "Good" : "Normal", style: GoogleFonts.dmSans(fontSize: 22, fontWeight: FontWeight.w500, color: toothState ? ColorsAsset.green : ColorsAsset.orange)),
          )
        ],
      ),
    );
  }
}