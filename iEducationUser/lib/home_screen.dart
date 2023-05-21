// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/navigation/app_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const route = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProfileLoading = true;
  @override
  void initState() {
    profileData();
    super.initState();
  }

  Future<void> profileData() async {
    isProfileLoading = true;
    await DataBaseHelper.filterData();
    isProfileLoading = false;
    // if (mounted) {
    setState(() {});
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Press Again to Exit',
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromRGBO(91, 62, 144, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        behavior: SnackBarBehavior.floating,
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: isProfileLoading == true
            ? Center(child: CircularProgressIndicator(color: primarycolor))
            : Stack(
                children: [
                  Container(
                    height: 0.4.sh,
                    decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 0.07.sh,
                        left: 0.03.sh,
                        right: 0.03.sh,
                      ),
                      child: animation(
                        context,
                        seconds: 500,
                        verticalOffset: -50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName}',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Text(
                                  '${DataBaseHelper.viewStudentData!.stream} (${DataBaseHelper.viewStudentData!.semester}) ',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    AppNavigation.shared
                                        .movetoStudentProfileScreen();
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        DataBaseHelper.viewStudentData!.image,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 0.04.sh,
                                      backgroundColor: background,
                                      backgroundImage: NetworkImage(
                                        DataBaseHelper.viewStudentData!.image,
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                      color: primarycolor,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0.23.sh,
                      left: 0.02.sh,
                      right: 0.02.sh,
                    ),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.015.sh),
                        borderSide: BorderSide(color: background),
                      ),
                      elevation: 5, 
                      child: Container(
                        height: 0.3.sh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.015.sh),
                          color: background,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeTopWidget(
                                  title: "ID Card",
                                  icon: "assets/icons/id-card.png",
                                  onPress: () async {
                                    AppNavigation.shared.movetoStudentIDCard();
                                    setState(() {});
                                  },
                                ),
                                HomeTopWidget(
                                  title: "Material",
                                  icon: "assets/icons/syllbus.png",
                                  onPress: () async {
                                    AppNavigation.shared.movetoMaterialScreen();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeTopWidget(
                                  title: "Course",
                                  icon: "assets/icons/course.png",
                                  onPress: () {
                                    AppNavigation.shared.movetoCourseScreen();
                                    setState(() {});
                                  },
                                ),
                                HomeTopWidget(
                                  title: "Notice",
                                  icon: "assets/icons/notice.png",
                                  onPress: () {
                                    AppNavigation.shared.movetoNoticeScreen();
                                  },
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                HomeTopWidget(
                                  title: "Teaching",
                                  icon: "assets/icons/teachingwork.png",
                                  onPress: () {
                                    AppNavigation.shared.movetoTeachingWork();
                                    setState(() {});
                                  },
                                ),
                                HomeTopWidget(
                                  title: "Time Table",
                                  icon: "assets/icons/timetable.png",
                                  onPress: () {
                                    AppNavigation.shared
                                        .movetoTimeTableScreen();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 0.56.sh,
                      left: 0.02.sh,
                      right: 0.02.sh,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Fees',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: primarycolor,
                            ),
                          ),
                        ),
                        Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: background),
                          ),
                          elevation: 7,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.11,
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: animation(
                                context,
                                seconds: 500,
                                verticalOffset: -50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Amount',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor,
                                          ),
                                        ),
                                        Text(
                                          "₹14500",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color: primarycolor,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: VerticalDivider(
                                        color: primarycolor,
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Paid Amount',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor,
                                          ),
                                        ),
                                        Text(
                                          "₹14500",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color: primarycolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: VerticalDivider(
                                        color: primarycolor,
                                        thickness: 1,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Remaing Amount',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontWeight: FontWeight.w600,
                                            color: primarycolor,
                                          ),
                                        ),
                                        Text(
                                          "₹00000",
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            color: primarycolor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          endIndent: 10,
                          indent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('Attendence',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: primarycolor,
                              )),
                        ),
                        Card(
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: background),
                          ),
                          elevation: 7,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              child: animation(
                                context,
                                seconds: 500,
                                verticalOffset: -50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Your Attendence',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: primarycolor,
                                      ),
                                    ),
                                    Text(
                                      '${DataBaseHelper.viewAttendenceData?.attendence ?? 0} %',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        fontWeight: FontWeight.bold,
                                        color: DataBaseHelper
                                                    .viewAttendenceData ==
                                                null
                                            ? primarycolor
                                            : ((DataBaseHelper
                                                            .viewAttendenceData!
                                                            .attendence ??
                                                        0) <
                                                    70)
                                                ? Colors.red
                                                : ((DataBaseHelper
                                                                .viewAttendenceData!
                                                                .attendence! >=
                                                            70) &&
                                                        (DataBaseHelper
                                                                .viewAttendenceData!
                                                                .attendence! <
                                                            85))
                                                    ? Colors.orange
                                                    : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class HomeTopWidget extends StatelessWidget {
  const HomeTopWidget(
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
    return animation(
      context,
      seconds: 500,
      verticalOffset: -50,
      child: Column(
        children: [
          GestureDetector(
            onTap: onPress,
            child: CircleAvatar(
                backgroundColor: primarycolor,
                radius: 0.040.sh,
                child: Image(
                  height: 0.040.sh,
                  fit: BoxFit.cover,
                  image: AssetImage(
                    icon,
                  ),
                )),
          ),
          SizedBox(
            height: 0.008.sh,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: primarycolor,
            ),
          ),
        ],
      ),
    );
  }
}
