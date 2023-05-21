import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/student_profile/student_profile_widget.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);
  static const route = 'studentProfileScreen';
  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  bool _customTileExpandedEducationDetail = false;
  bool _customTileExpandedPersonalDetail = false;
  List<Map<String, dynamic>> educationDetails = [];
  List<Map<String, dynamic>> personalDetails = [];
  @override
  void initState() {
    DataBaseHelper.filterData();
    educationDetails.clear();
    educationDetails.addAll([
      {
        'title': 'Stream',
        'subTitle': DataBaseHelper.viewStudentData!.stream,
      },
      {
        'title': 'Semester',
        'subTitle': DataBaseHelper.viewStudentData!.semester,
      },
      {
        'title': 'Enrollment No',
        'subTitle': DataBaseHelper.viewStudentData!.enrollNo,
      },
      {
        'title': 'SPID No',
        'subTitle': DataBaseHelper.viewStudentData!.spidNo,
      }
    ]);
    personalDetails.clear();
    personalDetails.addAll([
      {
        'title': 'Blood Group',
        'subTitle': DataBaseHelper.viewStudentData!.bloodGroup,
      },
      {
        'title': 'Date Of Birth',
        'subTitle': DataBaseHelper.viewStudentData!.dob,
      },
      {
        'title': 'Gender',
        'subTitle': DataBaseHelper.viewStudentData!.gender,
      },
      {
        'title': 'Caste',
        'subTitle': DataBaseHelper.viewStudentData!.caste,
      },
      {
        'title': 'Address',
        'subTitle': DataBaseHelper.viewStudentData!.address,
      },
      {
        'title': 'Pincode',
        'subTitle': DataBaseHelper.viewStudentData!.pincode,
      },
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Profile'),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 0.20.sh,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBox,
                      animation(
                        context,
                        seconds: 400,
                        verticalOffset: -100,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        DataBaseHelper.viewStudentData!.image,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundColor: background,
                                      radius: 40,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                            color: primarycolor)),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  sizedBox,
                                  Text(
                                    "${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName} ${DataBaseHelper.viewStudentData!.lName}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      // color: primarycolor,
                                    ),
                                  ),
                                  kHalfSizedBox,
                                  Text(
                                    "${DataBaseHelper.viewStudentData!.stream} (${DataBaseHelper.viewStudentData!.semester})",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      animation(
                        context,
                        seconds: 600,
                        verticalOffset: -100,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: primarycolor,
                                      ),
                                      kHalfWidthSizedBox,
                                      Text(
                                        DataBaseHelper.viewStudentData!.phoneNo,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  kHalfSizedBox,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: primarycolor,
                                      ),
                                      kHalfWidthSizedBox,
                                      SizedBox(
                                        width: 0.6.sw,
                                        child: Text(
                                          DataBaseHelper.viewStudentData!.email,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
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
                      sizedBox,
                      sizedBox,
                      animation(
                        context,
                        seconds: 800,
                        verticalOffset: -100,
                        child: Card(
                          elevation: 5,
                          color: background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                'Personal Details',
                                style: TextStyle(
                                  color: primarycolor,
                                  fontSize: 16,
                                  fontWeight: _customTileExpandedPersonalDetail
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                              iconColor: primarycolor,
                              collapsedIconColor: primarycolor,
                              trailing: Icon(
                                _customTileExpandedPersonalDetail
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_right,
                                color: primarycolor,
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() =>
                                    _customTileExpandedPersonalDetail =
                                        expanded);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // initiallyExpanded: true,
                              children: [
                                StudentProfileWidgetScreen(
                                    args: personalDetails),
                              ],
                            ),
                          ),
                        ),
                      ),
                      kHalfSizedBox,
                      animation(
                        context,
                        seconds: 1000,
                        verticalOffset: -100,
                        child: Card(
                          elevation: 5,
                          color: background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              title: Text(
                                'Education Details',
                                style: TextStyle(
                                  color: primarycolor,
                                  fontSize: 16,
                                  fontWeight: _customTileExpandedEducationDetail
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                              iconColor: primarycolor,
                              collapsedIconColor: primarycolor,
                              trailing: Icon(
                                _customTileExpandedEducationDetail
                                    ? Icons.arrow_drop_down_circle
                                    : Icons.arrow_right,
                              ),
                              onExpansionChanged: (bool expanded) {
                                setState(() =>
                                    _customTileExpandedEducationDetail =
                                        expanded);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // initiallyExpanded: true,
                              children: [
                                StudentProfileWidgetScreen(
                                    args: educationDetails),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
