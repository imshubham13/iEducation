import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/constant.dart';

Widget textField({
  String lableText = '',
  TextEditingController? controller,
  List<TextInputFormatter>? inputFormatters,
  IconData? prefixIcon,
  IconData? suffixIcon,
  bool obscureText = false,
  TextInputType? keyboardType,
  void Function()? onPressed,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 5,
    child: Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                lableText,
                style: TextStyle(
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          TextFormField(
            obscureText: obscureText,
            controller: controller,
            cursorHeight: 30,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            cursorColor: primarycolor,
            style: TextStyle(
              fontSize: 18.sp,
              color: primarycolor,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                prefixIcon,
                color: primarycolor,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  suffixIcon,
                  color: primarycolor,
                ),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
