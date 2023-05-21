import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class CulturalFestivalNotice extends StatefulWidget {
  const CulturalFestivalNotice({Key? key}) : super(key: key);
  static const route = 'culturalFestivalNotice';

  @override
  State<CulturalFestivalNotice> createState() => _CulturalFestivalNoticeState();
}

class _CulturalFestivalNoticeState extends State<CulturalFestivalNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await CulturalFestivalApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Cultural Festival'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: primarycolor),
            )
          : CulturalFestivalApi.culturalFestivalDataList.isEmpty
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
                        CulturalFestivalApi.culturalFestivalDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: CulturalFestivalApi
                            .culturalFestivalDataList[index].image,
                        title: CulturalFestivalApi
                            .culturalFestivalDataList[index].title,
                        description: CulturalFestivalApi
                            .culturalFestivalDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
