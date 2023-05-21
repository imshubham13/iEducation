import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/material_card.dart';
import 'package:user/common/pdf_viewer_dialog.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/database/network/network_api.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);
  static const route = 'courseScreen';

  @override
  State<CourseScreen> createState() => CourseScreenState();
}

class CourseScreenState extends State<CourseScreen> {
  bool isLoading = false;

  // Future<void> getData() async {
  //   isLoading = true;
  //   await DataBaseHelper.filterData();
  //   isLoading = false;
  //   setState(() {});
  // }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    isLoading = true;
    DataBaseHelper.filterData();
    isLoading = false;
    super.initState();

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
      appBar: appbar(context, title: 'Course'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : DataBaseHelper.viewCourseData.isEmpty
              ? Center(
                  child: Lottie.asset('assets/icons/Circle.json'),
                )
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: DataBaseHelper.viewCourseData.length,
                    itemBuilder: (context, index) => materialCard(
                      context,
                      isRowView:
                          DataBaseHelper.viewCourseData[index].isShowButton,
                      onTap: () {
                        indexs.removeAt(0);
                        indexs.insert(1, index);
                        setState(() {
                          DataBaseHelper
                              .viewCourseData[indexs[0]].isShowButton = false;
                          DataBaseHelper.viewCourseData[index].isShowButton =
                              DataBaseHelper
                                          .viewCourseData[index].isShowButton ==
                                      false
                                  ? true
                                  : false;
                        });
                      },
                      downloadOnTap: () async {
                        final List<Directory>? downloadsDir =
                            await getExternalStorageDirectories();
                        await FlutterDownloader.enqueue(
                          saveInPublicStorage: true,
                          url: DataBaseHelper.viewCourseData[index].fileName,
                          headers: {},
                          savedDir: downloadsDir![0].path,
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                      },
                      viewPdfOnTap: () {
                        viewPdfs(
                          context,
                          pdfUrl: DataBaseHelper.viewCourseData[index].fileName,
                          title:
                              '${DataBaseHelper.viewCourseData[index].subjectName} (${DataBaseHelper.viewCourseData[index].semester})',
                        );
                      },
                      sharePdfOnTap: () async {
                        String longUrl =
                            DataBaseHelper.viewCourseData[index].fileName;
                        String shortUrl =
                            await NetworkApi.getShortLink(longUrl);
                        await Share.share(
                          shortUrl,
                        );
                      },
                      subjectName:
                          DataBaseHelper.viewCourseData[index].subjectName,
                      stream:
                          '${DataBaseHelper.viewCourseData[index].stream} ${DataBaseHelper.viewCourseData[index].semester}',
                      dateTime:
                          '${DataBaseHelper.viewCourseData[index].date}  ${DataBaseHelper.viewCourseData[index].time}',
                      fileSize: DataBaseHelper.viewCourseData[index].fileSize,
                    ),
                  ),
                ),
    );
  }
}
