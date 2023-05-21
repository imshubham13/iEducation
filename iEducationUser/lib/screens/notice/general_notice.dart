import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:user/common/appbar.dart";
import "package:user/common/card.dart";
import "package:user/constant.dart";
import "package:user/database/database_api.dart";

class GeneralNotice extends StatefulWidget {
  const GeneralNotice({Key? key}) : super(key: key);
  static const route = 'generalNotice';

  @override
  State<GeneralNotice> createState() => _GeneralNoticeState();
}

class _GeneralNoticeState extends State<GeneralNotice> {
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    isLoading = true;
    await GeneralApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: "General"),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: primarycolor),
            )
          : GeneralApi.generalDataList.isEmpty
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
                    itemCount: GeneralApi.generalDataList.length,
                    itemBuilder: (context, index) {
                      return noticeDetailsCard(
                        context,
                        imageUrl: GeneralApi.generalDataList[index].image,
                        title: GeneralApi.generalDataList[index].title,
                        description:
                            GeneralApi.generalDataList[index].description,
                      );
                    },
                  ),
                ),
    );
  }
}
