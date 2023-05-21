// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/navigation/app_navigation.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({Key? key}) : super(key: key);
  static const route = 'noticeScreen';

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Notice'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              animation(
                context,
                seconds: 500,
                horizontalOffset: -100,
                verticalOffset: 100,
                child: NoticeCard(
                  title: "Culture Festival",
                  icon: "assets/icons/culture_festival.png",
                  onPress: () {
                    AppNavigation.shared.movetoCulturalFestivalNotice();
                    setState(() {});
                  },
                ),
              ),
              animation(
                context,
                seconds: 500,
                horizontalOffset: 100,
                verticalOffset: -100,
                child: NoticeCard(
                  title: "College Activity",
                  icon: "assets/icons/college_activity.png",
                  onPress: () {
                    AppNavigation.shared.movetoCollegeActivityNotice();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              animation(
                context,
                seconds: 500,
                horizontalOffset: -100,
                verticalOffset: 100,
                child: NoticeCard(
                  title: "Sports",
                  icon: "assets/icons/sport.png",
                  onPress: () {
                    AppNavigation.shared.movetoSportsNotice();
                    setState(() {});
                  },
                ),
              ),
              animation(
                context,
                seconds: 500,
                horizontalOffset: 100,
                verticalOffset: -100,
                child: NoticeCard(
                  title: "Competitive Exam",
                  icon: "assets/icons/exam.png",
                  onPress: () {
                    AppNavigation.shared.movetoCompatitiveExamNotice();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              animation(
                context,
                seconds: 500,
                horizontalOffset: -100,
                verticalOffset: 100,
                child: NoticeCard(
                  title: "Job Vacancy",
                  icon: "assets/icons/job_vacancy.png",
                  onPress: () {
                    AppNavigation.shared.movetoJobVacancynotice();
                    setState(() {});
                  },
                ),
              ),
              animation(
                context,
                seconds: 500,
                horizontalOffset: 100,
                verticalOffset: -100,
                child: NoticeCard(
                  title: "General",
                  icon: "assets/icons/general.png",
                  onPress: () {
                    AppNavigation.shared.movetoGeneralNotice();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  const NoticeCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  final String title;
  final String icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.only(
            top: kDefaultPadding * 0.5, bottom: kDefaultPadding * 0.6),
        decoration: BoxDecoration(
          color: primarycolor,
          borderRadius: BorderRadius.circular(kDefaultPadding * 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(icon),
              height: 50,
              width: 50,
            ),
            const SizedBox(
              height: kDefaultPadding * 0.8,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
