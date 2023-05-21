import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';

class IdCardScreen extends StatefulWidget {
  const IdCardScreen({Key? key}) : super(key: key);
  static const route = 'idCardScreen';
  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {
  @override
  void initState() {
    DataBaseHelper.filterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'ID CARD'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: animation(
            context,
            seconds: 1000,
            verticalOffset: 0.1,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 0.7054.sh,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.15.sh),
                          child: Container(
                            height: 0.5554.sh,
                            decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.14.sh, left: 0.20.sw),
                          child: Container(
                            height: 0.05.sh,
                            width: 0.15.sw,
                            color: background,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0.15.sh, left: 0.1525.sw),
                          child: Container(
                            height: 0.09.sh,
                            width: 0.1.sw,
                            decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.14.sh, left: 0.58.sw),
                          child: Container(
                            height: 0.05.sh,
                            width: 0.1.sw,
                            color: background,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0.15.sh, left: 0.622.sw),
                          child: Container(
                            height: 0.09.sh,
                            width: 0.1.sw,
                            decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.05.sh),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 0.2.sh,
                              width: 0.37.sw,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: background,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: background,
                                  border: Border.all(
                                    color: primarycolor,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      DataBaseHelper.viewStudentData!.image,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.28.sh),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IdCardWidget(
                                    title: "Name",
                                    value:
                                        '${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName} ${DataBaseHelper.viewStudentData!.lName}'),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "Stream",
                                    value:
                                        DataBaseHelper.viewStudentData!.stream),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "Semester",
                                    value: DataBaseHelper
                                        .viewStudentData!.semester),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "SPID No",
                                    value:
                                        DataBaseHelper.viewStudentData!.spidNo),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "Enrollment No",
                                    value: DataBaseHelper
                                        .viewStudentData!.enrollNo),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "Phone No",
                                    value: DataBaseHelper
                                        .viewStudentData!.phoneNo),
                                kHalfSizedBox,
                                IdCardWidget(
                                    title: "Address",
                                    value:
                                        '${DataBaseHelper.viewStudentData!.address} - ${DataBaseHelper.viewStudentData!.pincode}'),
                              ],
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
      ),
    );
  }
}

class IdCardWidget extends StatelessWidget {
  const IdCardWidget({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 0.33.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: background,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
            child: Text(
          " :   ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: background,
            fontSize: 20.sp,
          ),
        )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.36.sw,
              child: Text(
                value,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  color: background,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
