import 'dart:async';
import 'package:bacto_quest/components/tooth.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* ================================
   Tooth status from BLE / AI
   ================================ */
enum ToothStatus { good, normal, bad }

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int currentIndex = 0;

  /* ================================
     DATA RECEIVED FROM BLUETOOTH
     (simulated here)
     ================================ */
  List<ToothStatus> toothList = [];

  /* ================================
     OVERALL CALCULATED RESULT
     ================================ */
  String averageResult = "Calculating...";
  Color averageColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    // Simulate receiving data from BLE
    _receiveBleData();
  }

  /* ================================
     RECEIVE DATA FROM BLUETOOTH
     ================================ */
  void _receiveBleData() {
    // Simulated BLE data (0 = bad, 1 = normal, 2 = good)
    final rawBleData = List<int>.generate(32, (i) {
      if (i % 7 == 0) return 0;
      if (i % 4 == 0) return 1;
      return 2;
    });

    // Convert raw BLE data to ToothStatus
    toothList = rawBleData.map((v) {
      if (v == 0) return ToothStatus.bad;
      if (v == 1) return ToothStatus.normal;
      return ToothStatus.good;
    }).toList();

    // Calculate overall result
    _calculateAverageResult();
  }

  /* ================================
     CALCULATE GOOD / NORMAL / BAD
     ================================ */
  void _calculateAverageResult() {
    int good = toothList.where((t) => t == ToothStatus.good).length;
    int normal = toothList.where((t) => t == ToothStatus.normal).length;
    int bad = toothList.where((t) => t == ToothStatus.bad).length;

    if (bad > 6) {
      averageResult = "BAD";
      averageColor = Colors.red;
    } else if (normal > good) {
      averageResult = "NORMAL";
      averageColor = Colors.orange;
    } else {
      averageResult = "GOOD";
      averageColor = ColorsAsset.green;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, size: 40),
        ),
        title: Text(
          "Tooth Brushing",
          style: GoogleFonts.dmSans(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Result",
              style: GoogleFonts.dmSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Row(
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
                          if (i == 0) currentIndex = 1;
                          if (i == 1) currentIndex = 10;
                          if (i == 2) currentIndex = 19;
                          if (i == 3) currentIndex = 28;

                          return Column(
                            children: [
                              if (i == 3)
                                ...List.generate(
                                  5,
                                  (j) => Tooth(
                                    toothNumber: currentIndex + j,
                                    toothState: toothList[currentIndex + j - 1],
                                  ),
                                )
                              else
                                ...List.generate(
                                  7,
                                  (j) => Tooth(
                                    toothNumber: currentIndex + j,
                                    toothState: toothList[currentIndex + j - 1],
                                  ),
                                ),
                            ],
                          );
                        }),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /* ================================
                       DISPLAY AVERAGE RESULT
                       ================================ */
                    Container(
                      width: 180,
                      height: 120,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorsAsset.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Average Result",
                            style: GoogleFonts.dmSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            averageResult,
                            style: GoogleFonts.dmSans(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: averageColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
