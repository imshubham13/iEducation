import 'package:flutter/material.dart';
import 'package:user/common/navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/constant.dart';
import 'package:user/home_screen.dart';
import 'package:user/screens/settings_screen.dart';

import '../../navigation/app_navigation.dart';

class HomeScreenBottomBar extends StatefulWidget {
  const HomeScreenBottomBar({super.key});
  static const route = 'homeScreenBottomBar';

  @override
  State<HomeScreenBottomBar> createState() => _HomeScreenBottomBarState();
}

class _HomeScreenBottomBarState extends State<HomeScreenBottomBar>
    with TickerProviderStateMixin {
  List<Map> tabData = [
    {
      'icon': Icons.home,
      'text': 'Home',
    },
    {
      'icon': Icons.settings,
      'text': 'Setting',
    },
  ];
  int activeIndex = 0;
  List<Widget> screensList = [const HomeScreen(), const SettingScreen()];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarycolor,
        // await DataBaseHelper.filterData();
        // print(
        //     '*********>>>>>>>>>>>>> ${DataBaseHelper.viewAttendenceData.length}');
        // ignore: use_build_context_synchronously
        onPressed: SharedPref.getIsScanned == true
            ? null
            : () => AppNavigation.shared.moveToQrScreen(),
        // : () => showDialog(
        //       barrierColor: Colors.black87,
        //       context: context,
        //       builder: (context) => Center(
        //         child: Container(
        //           height: 250,
        //           width: 250,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(100),
        //           ),
        //           child: MobileScanner(
        //             fit: BoxFit.cover,
        //             controller: cameraController,
        //             onDetect: (barcode) async {

        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        child: SharedPref.getIsScanned == true
            ? Icon(
                Icons.check,
                color: background,
              )
            : Image(
                height: MediaQuery.of(context).size.height / 22,
                color: white,
                image: const AssetImage('assets/images/scanner.png'),
              ),
      ),
      body: NotificationListener<ScrollNotification>(
        child: NavigationScreen(screensList[activeIndex]),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: background,
        itemCount: tabData.length,
        tabBuilder: (index, isActive) {
          return Column(
            children: [
              Icon(tabData[index]['icon'], color: primarycolor),
              Text(
                tabData[index]['text'],
                style: TextStyle(color: primarycolor),
              )
            ],
          );
        },
        activeIndex: activeIndex,
        gapLocation: GapLocation.center,
        onTap: (index) => setState(() => activeIndex = index),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget currentPage;

  const NavigationScreen(this.currentPage, {super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.currentPage;
  }
}











