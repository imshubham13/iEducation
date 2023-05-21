import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class JobVacancyNotice extends StatefulWidget {
  const JobVacancyNotice({Key? key}) : super(key: key);
  static const route = 'jobVacancyNotice';

  @override
  State<JobVacancyNotice> createState() => _JobVacancyNoticeState();
}

class _JobVacancyNoticeState extends State<JobVacancyNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await JobVacancyApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'job Vacancy'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: primarycolor),
            )
          : JobVacancyApi.jobVacancyDataList.isEmpty
              ? Center(
                  child: Lottie.asset(
                    'assets/icons/Circle.json',
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                )
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: JobVacancyApi.jobVacancyDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: JobVacancyApi.jobVacancyDataList[index].image,
                        title: JobVacancyApi.jobVacancyDataList[index].title,
                        description:
                            JobVacancyApi.jobVacancyDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
