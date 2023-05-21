import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class CollegeActivityNotice extends StatefulWidget {
  const CollegeActivityNotice({Key? key}) : super(key: key);
  static const route = 'collegeActivityNotice';
  @override
  State<CollegeActivityNotice> createState() => _CollegeActivityNoticeState();
}

class _CollegeActivityNoticeState extends State<CollegeActivityNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await CollegeActivityApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'College Activity'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: primarycolor),
            )
          : CollegeActivityApi.collegeActivityDataList.isEmpty
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
                    itemCount:
                        CollegeActivityApi.collegeActivityDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: CollegeActivityApi
                            .collegeActivityDataList[index].image,
                        title: CollegeActivityApi
                            .collegeActivityDataList[index].title,
                        description: CollegeActivityApi
                            .collegeActivityDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
