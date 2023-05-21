import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/login_screen.dart';
import 'package:user/navigation/app_navigation.dart';
import 'package:user/screens/course_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool settingScreenLoadin = false;
  @override
  void initState() {
    super.initState();
  }

  viewFilterData() async {
    settingScreenLoadin = true;
    await DataBaseHelper.filterData();
    settingScreenLoadin = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 25,
                      color: kOtherColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  sizedBox,
                  animation(
                    context,
                    seconds: 500,
                    horizontalOffset: -10,
                    child: Row(
                      children: [
                        DataBaseHelper.viewStudentData == null
                            ? Container()
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: kOtherColor,
                                backgroundImage: NetworkImage(
                                  DataBaseHelper.viewStudentData!.image,
                                ),
                              ),
                        kWidthSizedBox,
                        DataBaseHelper.viewStudentData == null
                            ? Container()
                            : Text(
                                '${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: kOtherColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                      ],
                    ),
                  ),
                  sizedBox,
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: animation(
                          context,
                          seconds: 500,
                          horizontalOffset: -10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SettingWidget(
                                title: "Assignment",
                                icon: "assets/icons/assignment.png",
                                onPress: () {
                                  AppNavigation.shared.movetoAssignmentScreen();
                                  setState(() {});
                                },
                              ),
                              const Divider(),
                              SettingWidget(
                                title: "Results",
                                icon: "assets/icons/results.png",
                                onPress: () {
                                  AppNavigation.shared.movetoResultScreen();
                                },
                              ),
                              const Divider(),
                              SettingWidget(
                                title: "Course",
                                icon: "assets/icons/course.png",
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CourseScreen(),
                                    ),
                                  );
                                },
                              ),
                              const Divider(),
                              SettingWidget(
                                title: "Staff List",
                                icon: "assets/icons/staff.png",
                                onPress: () {
                                  AppNavigation.shared.movetoStaffListcreen();
                                  setState(() {});
                                },
                              ),
                              const Divider(),
                              SettingWidget(
                                title: "Fees",
                                icon: "assets/icons/fees.png",
                                onPress: () {},
                              ),
                              const Divider(),
                              SettingWidget(
                                title: "Logout",
                                icon: "assets/icons/logout.png",
                                onPress: () async {
                                  DataBaseHelper.clearAllData();
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.remove("userMobileNumber");
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingWidget extends StatelessWidget {
  const SettingWidget(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primarycolor,
          radius: 25,
          child: Image(
            height: 30,
            image: AssetImage(icon),
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: primarycolor,
          ),
        ),
      ),
    );
  }
}
