import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/constant.dart';

class TimeTableColumn extends StatelessWidget {
  const TimeTableColumn({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: primarycolor,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.005,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Divider(
          thickness: 1,
        ),
      ],
    );
  }
}
