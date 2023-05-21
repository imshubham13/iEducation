import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:user/common/appbar.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/data/database_service.dart';
import 'package:user/database/database_api.dart';
import 'package:user/database/database_model.dart';
import 'package:user/navigation/app_navigation.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});
  static const route = 'qrScanner';

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      AppNavigation.shared.goNextFromSplash();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await DataBaseHelper.filterData();
  }

  Barcode? result;
  final qrKey = GlobalKey();
  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: appbar(context, title: 'Scanner'),
        body: Center(
          child: QRView(
            overlayMargin: const EdgeInsets.all(10),
            cameraFacing: CameraFacing.back,
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderRadius: 10,
              borderWidth: 5,
              borderColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    int masterFlag = 0, slaveFlag = 0;
    const expectedCodes = 1234567;
    controller.scannedDataStream.listen((scanData) async {
      if (expectedCodes == int.parse(scanData.code!)) {
        SharedPref.setIsScanned = true;
        SharedPref.setScannedDate = DateTime.now().toString();
        if (DataBaseHelper.viewAttendenceData?.key !=
                DataBaseHelper.viewStudentData!.key &&
            masterFlag == 0) {
          Attendence obj = Attendence(
            name:
                '${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName} ${DataBaseHelper.viewStudentData!.lName}',
            stream: DataBaseHelper.viewStudentData!.stream,
            semester: DataBaseHelper.viewStudentData!.semester,
            image: DataBaseHelper.viewStudentData!.image,
            key: DataBaseHelper.viewStudentData!.key,
            attendence: double.parse((100 / 183).toStringAsFixed(2)),
          );
          masterFlag = 1;
          slaveFlag = 1;
          await AttendenceApi.attendenceAddData(obj: obj);
          controller.dispose();
          await AppNavigation.shared.goNextFromSplash();
        } else {
          if (slaveFlag == 0) {
            Attendence obj = Attendence(
              name: DataBaseHelper.viewAttendenceData!.name,
              image: DataBaseHelper.viewAttendenceData!.image,
              semester: DataBaseHelper.viewAttendenceData!.semester,
              stream: DataBaseHelper.viewAttendenceData!.stream,
              key: DataBaseHelper.viewAttendenceData!.key,
              attendence: double.parse(
                  ((100 / 183) + DataBaseHelper.viewAttendenceData!.attendence!)
                      .toStringAsFixed(2)),
            );
            slaveFlag = 1;
            await AttendenceApi.attendenceUpdateData(obj: obj);
            controller.dispose();
            await AppNavigation.shared.goNextFromSplash();
          }
        }
      }
    });
  }
}
