import 'package:bacto_quest/pages/brushing_page.dart';
import 'package:bacto_quest/pages/home_page.dart';
import 'package:bacto_quest/pages/home_page_unconnected.dart';
import 'package:bacto_quest/pages/records_page.dart';
import 'package:bacto_quest/pages/setting_page.dart';
import 'package:bacto_quest/services/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navigation extends StatefulWidget {
  Navigation({super.key, required this.connected});

  bool connected;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var tabs = [widget.connected ? HomePage() : HomePageUnconnected(), BrushingPage(), RecordsPage(), SettingPage()];

    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedIconTheme: const IconThemeData(color: ColorsAsset.primary),
        unselectedIconTheme: const IconThemeData(color: ColorsAsset.darkGrey),
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/dentistry.svg", width: 30, colorFilter: ColorFilter.mode(currentIndex == 1 ? ColorsAsset.primary : ColorsAsset.darkGrey, BlendMode.srcIn)), label: "Brushing"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/voicemail_2.svg", width: 30, colorFilter: ColorFilter.mode(currentIndex == 2 ? ColorsAsset.primary : ColorsAsset.darkGrey, BlendMode.srcIn)), label: "Records"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Setting")
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        }
      ),
    );
  }
}