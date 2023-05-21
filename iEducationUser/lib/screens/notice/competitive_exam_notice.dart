import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class CompetitiveExamNotice extends StatefulWidget {
  const CompetitiveExamNotice({Key? key}) : super(key: key);
  static const route = 'competitiveExamNotice';

  @override
  State<CompetitiveExamNotice> createState() => _CompetitiveExamNoticeState();
}

class _CompetitiveExamNoticeState extends State<CompetitiveExamNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await CompetitiveExamApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Compatitive Exam'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: primarycolor),
            )
          : CompetitiveExamApi.competitiveExamDataList.isEmpty
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
                        CompetitiveExamApi.competitiveExamDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: CompetitiveExamApi
                            .competitiveExamDataList[index].image,
                        title: CompetitiveExamApi
                            .competitiveExamDataList[index].title,
                        description: CompetitiveExamApi
                            .competitiveExamDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
