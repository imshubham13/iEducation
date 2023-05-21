import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// const Color kPrimaryColor = Color(0xFF345FB4);
// const Color kSecondaryColor = Color(0xFF6789CA);
const Color kOtherColor = Color(0xFFF4F6F7);
Color primarycolor = HexColor('#5b3e90');
Color secoundrycolor = HexColor('#6b519b');
Color background = HexColor('#efecf4');
const Color white = Colors.white;
Color sixth = HexColor('#402b65');

const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);

const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

const kTopBorderRadius = BorderRadius.only(
  topRight: Radius.circular(kDefaultPadding),
  topLeft: Radius.circular(kDefaultPadding),
);

const kBottomSheetShape =
    RoundedRectangleBorder(borderRadius: kTopBorderRadius);

final kElevatButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: primarycolor,
  fixedSize: const Size(100, 40),
);

const kTextContentPadding = EdgeInsets.all(12);

const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

String gender = "Gender", male = "Male", female = "Female";
