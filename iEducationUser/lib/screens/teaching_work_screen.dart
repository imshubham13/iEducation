import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/appbar.dart';

class TeachingWorkScreen extends StatefulWidget {
  const TeachingWorkScreen({Key? key}) : super(key: key);
  static const route = 'teachingWorkScreen';

  @override
  State<TeachingWorkScreen> createState() => _TeachingWorkScreenState();
}

class _TeachingWorkScreenState extends State<TeachingWorkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Teaching Work'),
      body: Center(
        child: Lottie.asset(
          'assets/icons/Circle.json',
          repeat: true,
          reverse: true,
          animate: true,
        ),
      ),
    );
  }
}
