import 'package:flutter/material.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';

class StudentProfileWidgetScreen extends StatelessWidget {
  const StudentProfileWidgetScreen({Key? key, required this.args})
      : super(key: key);

  final List<Map<String, dynamic>> args;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.045,
        right: MediaQuery.of(context).size.width * 0.045,
      ),
      child: Column(
        children: List.generate(
          args.length,
          (index) => animation(
            context,
            seconds: 700,
            horizontalOffset: -100,
            child: commonTile(context,
                title: args[index]['title'],
                value: args[index]['subTitle'],
                length: args.length,
                index: index),
          ),
        ),
      ),
    );
  }

  Widget commonTile(BuildContext context,
      {required String title,
      required String value,
      required int length,
      required int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: primarycolor,
              fontSize: MediaQuery.of(context).size.width * 0.04),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: Theme.of(context).textTheme.bodySmall),
            const Icon(
              Icons.lock_outline,
              size: 10,
            ),
          ],
        ),
        index < length - 1
            ? const Divider(
                thickness: 1.0,
              )
            : kHalfSizedBox,
      ],
    );
  }
}
