import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class SportNotice extends StatefulWidget {
  const SportNotice({Key? key}) : super(key: key);
  static const route = 'sportNotice';

  @override
  State<SportNotice> createState() => _SportNoticeState();
}

class _SportNoticeState extends State<SportNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await SportsApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Sports Notice'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : SportsApi.sportsDataList.isEmpty
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
                    itemCount: SportsApi.sportsDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: SportsApi.sportsDataList[index].image,
                        title: SportsApi.sportsDataList[index].title,
                        description:
                            SportsApi.sportsDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
