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

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);
  static const route = 'resultScreen';
  @override
  State<ResultScreen> createState() => ResultScreenState();
}

class ResultScreenState extends State<ResultScreen> {
  bool isLoading = false;

  // getData() async {
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
    // getData();
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
      appBar: appbar(context, title: 'Result'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : DataBaseHelper.viewResultData.isEmpty
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
                    itemCount: DataBaseHelper.viewResultData.length,
                    itemBuilder: (context, index) => materialCard(
                      context,
                      isRowView:
                          DataBaseHelper.viewResultData[index].isShowButton,
                      onTap: () {
                        indexs.removeAt(0);
                        indexs.insert(1, index);
                        setState(() {
                          DataBaseHelper
                              .viewResultData[indexs[0]].isShowButton = false;
                          DataBaseHelper.viewResultData[index].isShowButton =
                              DataBaseHelper
                                          .viewResultData[index].isShowButton ==
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
                          url: DataBaseHelper.viewResultData[index].fileName,
                          headers: {},
                          savedDir: downloadsDir![0].path,
                          showNotification: true,
                          openFileFromNotification: true,
                        );
                      },
                      viewPdfOnTap: () {
                        viewPdfs(
                          context,
                          pdfUrl: DataBaseHelper.viewResultData[index].fileName,
                          title:
                              '${DataBaseHelper.viewResultData[index].examType} (${DataBaseHelper.viewResultData[index].semester})',
                        );
                      },
                      sharePdfOnTap: () async {
                        String longUrl =
                            DataBaseHelper.viewResultData[index].fileName;
                        String shortUrl =
                            await NetworkApi.getShortLink(longUrl);
                        await Share.share(
                          shortUrl,
                        );
                      },
                      subjectName:
                          DataBaseHelper.viewResultData[index].examType,
                      stream:
                          '${DataBaseHelper.viewResultData[index].stream} ${DataBaseHelper.viewResultData[index].semester}',
                      dateTime:
                          '${DataBaseHelper.viewResultData[index].date}  ${DataBaseHelper.viewResultData[index].time}',
                      fileSize: DataBaseHelper.viewResultData[index].fileSize,
                    ),
                  ),
                ),
    );
  }
}
