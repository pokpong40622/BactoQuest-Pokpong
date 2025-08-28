import 'dart:convert';
import 'package:bacto_quest/services/KeaneData.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageUnconnected extends StatelessWidget {
  HomePageUnconnected({super.key});


  @override
  Widget build(BuildContext context) {
    var writeCharacteristic;
    final keaneData = context.read<KeaneData>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
        leading: Image.asset("assets/logo.png"),
        actions: [Icon(Icons.notifications, color: Colors.black, size: 30), SizedBox(width: 20)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Are you ready to brush your teeths?", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black))),

          SizedBox(height: 15),

          Center(
            child: GestureDetector(
              onTap: () async {
                await FlutterBluePlus.turnOn();

                FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
                FlutterBluePlus.onScanResults.listen((results) async {
                if (results.isNotEmpty) {
                    var result = results.last;
                    if (result.advertisementData.advName.contains("Keane")) {
                      try {
                        await FlutterBluePlus.stopScan();

                        await result.device.connect();

                        var services = await result.device.discoverServices();

                        for (var s in services) {
                          // check if services length is more than 4
                          if (s.serviceUuid.toString().length > 4) {
                            // list all characteristics
                            var characteristics = s.characteristics;

                            // loop through characteristics
                            for (var c in characteristics) {
                              var descriptors = c.descriptors;

                              // variable desciptor
                              String? descriptor;

                              // loop through descriptors
                              for (var d in descriptors) {
                                // read descriptor in byte
                                var value = await d.read();

                                // read descriptor in string
                                descriptor = utf8.decode(value);
                              }
                              print(descriptor);

                              // check if descriptor match any prefixes

                              // filamentize status notify
                              if (descriptor!.contains("write")) {
                                writeCharacteristic = c;

                                keaneData.changeWriteChracteristic(characteristic: c);

                                await keaneData.writeCharacteristic!.write(utf8.encode("B-1"));
                              }
                            }
                          }
                        }
                      } catch (error) {
                        Navigator.pop(context);

                        print(error);

                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: Text("Error", style: GoogleFonts.dmSans(color: ColorsAsset.red, fontWeight: FontWeight.bold)),
                          content: Text("Something went wrong...", style: GoogleFonts.dmSans(color: Colors.black, fontWeight: FontWeight.w500)),
                          actions: [TextButton(onPressed: () {Navigator.pop(context);}, child: Text("OK", style: GoogleFonts.dmSans(color: ColorsAsset.primary, fontWeight: FontWeight.w500)))],
                        ));
                      }
                    }
                }
              });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: 450,
                decoration: BoxDecoration(
                  color: ColorsAsset.primary,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Text("I'm ready!", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white))
              ),
            ),
          )
        ],
      ),
    );
  }
}