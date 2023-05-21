import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';

Widget noticeDetailsCard(
  BuildContext context, {
  required String imageUrl,
  String title = '',
  String description = '',
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: animation(
      context,
      seconds: 700,
      child: Card(
        elevation: 5,
        color: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(color: primarycolor)),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title : ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: primarycolor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.715,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description : ',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: primarycolor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 0.52.sw,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
