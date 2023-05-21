import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/database/database_api.dart';
import 'package:user/navigation/app_navigation.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({Key? key}) : super(key: key);
  static const route = 'staffListScreen';
  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    await StaffListApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Staff List'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : StaffListApi.staffDataList.isEmpty
              ? Center(
                  child: Lottie.asset(
                    'assets/icons/Circle.json',
                  ),
                )
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: StaffListApi.staffDataList.length,
                    itemBuilder: (context, index) {
                      return animation(
                        context,
                        seconds: 500,
                        verticalOffset: -50,
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          elevation: 5,
                          color: background,
                          child: ListTile(
                            onTap: () {
                              AppNavigation.shared
                                  .movetoStaffProfilecreen({'index': index});
                              setState(() {});
                            },
                            leading: CachedNetworkImage(
                              imageUrl: StaffListApi.staffDataList[index].image,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 50,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                color: primarycolor,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(
                              StaffListApi.staffDataList[index].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(
                              StaffListApi.staffDataList[index].degree,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
