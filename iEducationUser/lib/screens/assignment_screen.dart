// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/pdf_viewer_dialog.dart';
import 'package:user/common/widget_animation.dart/fade_animation.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/database/network/network_api.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static const route = 'assignment';
  @override
  State<AssignmentScreen> createState() => AssignmentScreenState();
}

class AssignmentScreenState extends State<AssignmentScreen> {
  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    await DataBaseHelper.filterData();
    isLoading = false;
    setState(() {});
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    getData();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  List indexs = [0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Assignment'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : DataBaseHelper.viewAssignmentData.isEmpty
              ? Center(child: Lottie.asset('assets/icons/Circle.json'))
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: DataBaseHelper.viewAssignmentData.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        indexs.removeAt(0);
                        indexs.insert(1, index);
                        setState(() {
                          DataBaseHelper.viewAssignmentData[indexs[0]]
                              .isShowButton = false;
                          DataBaseHelper.viewAssignmentData[index]
                              .isShowButton = DataBaseHelper
                                      .viewAssignmentData[index].isShowButton ==
                                  false
                              ? true
                              : false;
                        });
                      },
                      child: animation(
                        context,
                        seconds: 500,
                        verticalOffset: -50,
                        child: Card(
                          color: background,
                          elevation: 3,
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.695,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          DataBaseHelper
                                              .viewAssignmentData[index]
                                              .subjectName,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: primarycolor,
                                          ),
                                        ),
                                        Text(
                                          DataBaseHelper
                                              .viewAssignmentData[index]
                                              .noOfAssignment,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '${DataBaseHelper.viewAssignmentData[index].stream} ${DataBaseHelper.viewAssignmentData[index].semester}',
                                        ),
                                        Text(
                                          '${DataBaseHelper.viewAssignmentData[index].date}  ${DataBaseHelper.viewAssignmentData[index].time}',
                                        ),
                                        Text(
                                            "${DataBaseHelper.viewAssignmentData[index].fileSize} MB"),
                                      ],
                                    ),
                                  ),
                                ),
                                DataBaseHelper
                                        .viewAssignmentData[index].isShowButton
                                    ? animation(
                                        context,
                                        seconds: 400,
                                        verticalOffset: 50,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Divider(
                                              color: primarycolor,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    final List<Directory>?
                                                        downloadsDir =
                                                        await getExternalStorageDirectories();
                                                    await FlutterDownloader
                                                        .enqueue(
                                                      saveInPublicStorage: true,
                                                      url: DataBaseHelper
                                                          .viewAssignmentData[
                                                              index]
                                                          .fileName,
                                                      headers: {},
                                                      savedDir:
                                                          downloadsDir![0].path,
                                                      showNotification: true,
                                                      openFileFromNotification:
                                                          true,
                                                    );
                                                  },
                                                  child: Text(
                                                    'Download',
                                                    style: TextStyle(
                                                      color: primarycolor,
                                                    ),
                                                  ),
                                                ),
                                                Lottie.asset(
                                                  'assets/icons/download.json',
                                                  fit: BoxFit.cover,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.037,
                                                ),
                                                SizedBox(
                                                  height: 0.05.sh,
                                                  child: VerticalDivider(
                                                    color: primarycolor,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    viewPdfs(
                                                      context,
                                                      pdfUrl: DataBaseHelper
                                                          .viewAssignmentData[
                                                              index]
                                                          .fileName,
                                                      title:
                                                          '${DataBaseHelper.viewAssignmentData[index].subjectName} (${DataBaseHelper.viewAssignmentData[index].semester})',
                                                    );
                                                  },
                                                  child: Text(
                                                    'View',
                                                    style: TextStyle(
                                                      color: primarycolor,
                                                    ),
                                                  ),
                                                ),
                                                Lottie.asset(
                                                  'assets/icons/eye.json',
                                                  fit: BoxFit.scaleDown,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.027,
                                                ),
                                                SizedBox(
                                                  height: 0.05.sh,
                                                  child: VerticalDivider(
                                                    color: primarycolor,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    String longUrl =
                                                        DataBaseHelper
                                                            .viewAssignmentData[
                                                                index]
                                                            .fileName;
                                                    String shortUrl =
                                                        await NetworkApi
                                                            .getShortLink(
                                                      longUrl,
                                                    );
                                                    await Share.share(
                                                      shortUrl,
                                                    );
                                                  },
                                                  child: Text(
                                                    'Share',
                                                    style: TextStyle(
                                                        color: primarycolor),
                                                  ),
                                                ),
                                                Lottie.asset(
                                                  'assets/icons/share.json',
                                                  fit: BoxFit.scaleDown,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.017,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
