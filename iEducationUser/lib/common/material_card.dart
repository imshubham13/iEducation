import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';

Widget materialCard(
  BuildContext context, {
  String subjectName = '',
  String stream = '',
  String dateTime = '',
  String fileSize = '',
  required void Function()? downloadOnTap,
  required void Function()? viewPdfOnTap,
  required void Function()? sharePdfOnTap,
  required void Function()? onTap,
  bool isRowView = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: animation(
        context,
        seconds: 500,
        verticalOffset: -50,
        child: Card(
          elevation: 5,
          color: background,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        subjectName,
                        style: TextStyle(
                          fontSize: 20,
                          color: primarycolor,
                        ),
                      ),
                      Text(stream),
                      Text(dateTime),
                      Text("$fileSize MB"),
                    ],
                  ),
                ),
                isRowView
                    ? animation(
                        context,
                        seconds: 400,
                        verticalOffset: 50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              color: primarycolor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: downloadOnTap,
                                  child: Text(
                                    'Download',
                                    style: TextStyle(color: primarycolor),
                                  ),
                                ),
                                Lottie.asset(
                                  'assets/icons/download.json',
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height *
                                      0.037,
                                ),
                                SizedBox(
                                  height: 0.05.sh,
                                  child: VerticalDivider(
                                    color: primarycolor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: viewPdfOnTap,
                                  child: Text(
                                    'View',
                                    style: TextStyle(color: primarycolor),
                                  ),
                                ),
                                Lottie.asset(
                                  'assets/icons/eye.json',
                                  fit: BoxFit.scaleDown,
                                  height: MediaQuery.of(context).size.height *
                                      0.027,
                                ),
                                SizedBox(
                                  height: 0.05.sh,
                                  child: VerticalDivider(
                                    color: primarycolor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: sharePdfOnTap,
                                  child: Text(
                                    'Share',
                                    style: TextStyle(color: primarycolor),
                                  ),
                                ),
                                Lottie.asset(
                                  'assets/icons/share.json',
                                  fit: BoxFit.scaleDown,
                                  height: MediaQuery.of(context).size.height *
                                      0.017,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
