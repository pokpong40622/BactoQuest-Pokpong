import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordComponent extends StatelessWidget {
  RecordComponent({super.key, required this.date, required this.time});

  var date;
  var time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: EdgeInsets.only(bottom: 15),
      width: 500,
      height: 150,
      decoration: BoxDecoration(
        color: ColorsAsset.grey,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$date [$time]", style: GoogleFonts.dmSans(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black)),
              Row(
                              children: [
                  Text("Level: ", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text("Good", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: ColorsAsset.green))
                ],
              )
            ],
          ),
          Text("More Details...", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: ColorsAsset.darkGrey))
        ],
      ),
    );
  }
}