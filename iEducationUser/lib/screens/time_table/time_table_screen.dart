import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/screens/time_table/time_table_widget.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);
  static const route = 'TimeTableScreen';

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    isLoading = true;
    await DataBaseHelper.filterData();
    isLoading = false;
    setState(() {});
  }

  List<Map<String, dynamic>> personalDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Time Table'),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: primarycolor,
                ),
              )
            : DataBaseHelper.viewTimeTableData.isEmpty
                ? Center(
                    child: Lottie.asset(
                      'assets/icons/Circle.json',
                      repeat: true,
                      reverse: true,
                      animate: true,
                    ),
                  )
                : ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: DataBaseHelper.viewTimeTableData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: animation(
                          context,
                          seconds: 700,
                          verticalOffset: -50,
                          child: Card(
                            color: background,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  TimeTableColumn(
                                    title: "Subject Name",
                                    value: DataBaseHelper
                                        .viewTimeTableData[index].lectureName,
                                  ),
                                  TimeTableColumn(
                                    title: "Lecture Start Time",
                                    value: DataBaseHelper
                                        .viewTimeTableData[index]
                                        .lectureStartTime,
                                  ),
                                  TimeTableColumn(
                                    title: "Lecture End Time",
                                    value: DataBaseHelper
                                        .viewTimeTableData[index]
                                        .lectureEndTime,
                                  ),
                                  TimeTableColumn(
                                    title: "Lecture Date",
                                    value: DataBaseHelper
                                        .viewTimeTableData[index].lectureDate,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
