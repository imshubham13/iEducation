import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/constant.dart';
import 'package:user/navigation/navigator.dart';
import 'package:user/navigation/route_observer.dart';
import 'package:user/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.init;

  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const IEducationUser());
}

class IEducationUser extends StatelessWidget {
  const IEducationUser({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: primarycolor),
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            navigatorKey: NavigationUtilities.key,
            onGenerateRoute: onGenerateRoute,
            navigatorObservers: [routeObserver],
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
