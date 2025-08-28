import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var editMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset("assets/logo.png"),
        title: Text("Setting", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.account_circle_outlined, color: ColorsAsset.primary, size: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.black)),
                    Text("AtomTuaJing", style: GoogleFonts.dmSans(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black, height: .75))
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 20),

          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 25, right: 25),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsAsset.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 30, color: Colors.white),

                          SizedBox(width: 10),

                          Text("Account Info", style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))
                        ],
                      ),

                      SizedBox(height: 5),

                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text("Name", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(
                            width: 10,
                            child: Text(":", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 400,
                            child: Text("Pariyakitti Pattanaleenakul", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text("Age", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(
                            width: 10,
                            child: Text(":", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 400,
                            child: Text("16", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                        ],
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/alarm.svg", width: 30, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),

                          SizedBox(width: 10),

                          Text("Reminder Time", style: GoogleFonts.dmSans(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))
                        ],
                      ),

                      SizedBox(height: 5),

                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text("Morning", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(
                            width: 10,
                            child: Text(":", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 50,
                            child: Text("7:30", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: Text("a.m.", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text("Night", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(
                            width: 10,
                            child: Text(":", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 40),
                          SizedBox(
                            width: 50,
                            child: Text("8:00", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 50,
                            child: Text("p.m.", style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))),
                        ],
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        editMode = 1;
                      });
                    },
                    child: Icon(Icons.border_color, color: Colors.white, size: 30))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}