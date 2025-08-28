import 'package:bacto_quest/components/tooth.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryPage extends StatelessWidget {
  final List<dynamic> toothList;

  SummaryPage({super.key, required this.toothList});

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 40)),
        title: Text("Tooth Brushing", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
          
              Text("Result", style: GoogleFonts.dmSans(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
          
              SizedBox(height: 10),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/mouth.png", height: 430),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(4, (i) {
                            if (i == 0) {
                              currentIndex = 1;
                            } 
                            if (i == 1) {
                              currentIndex = 10;
                            }
                            if (i == 2) {
                              currentIndex = 19;
                            }
                            if (i == 3) {
                              currentIndex = 28;
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (i == 3) ...List.generate(5, (j) => Tooth(toothNumber: currentIndex + j, toothState: toothList[currentIndex + j - 1]))
                                else ...List.generate(7, (j) => Tooth(toothNumber: currentIndex + j, toothState: toothList[currentIndex + j - 1]))
                              ],
                            );
                          }
                        )
                        ]
                      ),
          
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 180,
                        height: 120,
                        decoration: BoxDecoration(
                          color: ColorsAsset.grey,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Average Result", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("GOOD", style: GoogleFonts.dmSans(fontSize: 30, fontWeight: FontWeight.bold, color: ColorsAsset.green)),
                        ],
                    ),
                  )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}