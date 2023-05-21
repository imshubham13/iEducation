import 'package:flutter/material.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/cashed_network_image.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/database/database_api.dart';
import 'package:user/screens/staff_list/staff_profile_widget.dart';

class StaffProfileScreen extends StatefulWidget {
  final Map<String, dynamic> args;
  const StaffProfileScreen({Key? key, required this.args}) : super(key: key);
  static const route = 'staffProfileScreen';

  @override
  State<StaffProfileScreen> createState() => _StaffProfileScreenState();
}

class _StaffProfileScreenState extends State<StaffProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Staff Profile'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: animation(
            context,
            seconds: 1000,
            verticalOffset: 0.1,
            child: ListView(
              children: [
                Center(
                  child: cachedNetworkImage(context,
                      imageUrl: StaffListApi
                          .staffDataList[widget.args['index']].image),
                ),
                sizedBox,
                StaffProfileWidgetScreen(
                    title: "Name",
                    value:
                        StaffListApi.staffDataList[widget.args['index']].name),
                StaffProfileWidgetScreen(
                    title: "Email ID",
                    value:
                        StaffListApi.staffDataList[widget.args['index']].email),
                StaffProfileWidgetScreen(
                    title: "Contact No",
                    value: StaffListApi
                        .staffDataList[widget.args['index']].phoneNo),
                StaffProfileWidgetScreen(
                    title: "Post",
                    value:
                        StaffListApi.staffDataList[widget.args['index']].post),
                StaffProfileWidgetScreen(
                    title: "Subject",
                    value: StaffListApi
                        .staffDataList[widget.args['index']].subject),
                StaffProfileWidgetScreen(
                    title: "Experience",
                    value: StaffListApi
                        .staffDataList[widget.args['index']].experience),
                StaffProfileWidgetScreen(
                    title: "Degree",
                    value: StaffListApi
                        .staffDataList[widget.args['index']].degree),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
