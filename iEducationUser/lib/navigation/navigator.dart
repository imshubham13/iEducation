import 'package:flutter/material.dart';
import 'package:user/home_screen.dart';
import 'package:user/login_screen.dart';
import 'package:user/navigation/constants.dart';
import 'package:user/navigation/fade_route.dart';
import 'package:user/navigation/slide_transit.dart';
import 'package:user/screens/assignment_screen.dart';
import 'package:user/screens/course_screen.dart';
import 'package:user/screens/home_screen/home_screen_bottombar.dart';
import 'package:user/screens/id_card_screen.dart';
import 'package:user/screens/material_screen.dart';
import 'package:user/screens/notice/college_activity_notice.dart';
import 'package:user/screens/notice/competitive_exam_notice.dart';
import 'package:user/screens/notice/cultural_festvial_notice.dart';
import 'package:user/screens/notice/general_notice.dart';
import 'package:user/screens/notice/job_vacancy_notice.dart';
import 'package:user/screens/notice/notice_screen.dart';
import 'package:user/screens/notice/sport_notice.dart';
import 'package:user/screens/qr_screen.dart';
import 'package:user/screens/result_screen.dart';
import 'package:user/screens/staff_list/staff_profile.dart';
import 'package:user/screens/staff_list/stafflist_screen.dart';
import 'package:user/screens/teaching_work_screen.dart';
import 'package:user/screens/time_table/time_table_screen.dart';
import 'package:user/student_profile/student_profile_screen.dart';

class NavigationUtilities {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void push(Widget widget, {String? name}) {
    key.currentState!.push(MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: name),
    ));
  }

  static Future<dynamic> pushRoute(String route,
      {RouteType type = RouteType.left, Map? args}) async {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return await key.currentState!.pushNamed(
      route,
      arguments: args,
    );
  }

  static Future<dynamic> pushNamed(String route,
      {RouteType type = RouteType.left, Map? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushNamed(
      route,
      arguments: args,
    );
  }

  static Future<dynamic>? pushReplacementNamed(String route,
      {RouteType type = RouteType.left, Map? args}) {
    args ??= <String, dynamic>{};
    args["routeType"] = type;
    return key.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  static RoutePredicate namePredicate(List<String> names) {
    return (route) =>
        !route.willHandlePopInternally &&
        route is ModalRoute &&
        (names.contains(route.settings.name));
  }
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final routeName = settings.name;
  final arguments = settings.arguments as Map<String, dynamic>? ?? {};
  final routeType =
      arguments["routeType"] as RouteType? ?? RouteType.defaultRoute;

  Widget? screen;

  switch (routeName) {
    case LoginScreen.route:
      screen = const LoginScreen();
      break;
    case HomeScreen.route:
      screen = const HomeScreen();
      break;
    case HomeScreenBottomBar.route:
      screen = const HomeScreenBottomBar();
      break;
    case QrScannerScreen.route:
      screen = const QrScannerScreen();
      break;

    case StudentProfileScreen.route:
      screen = const StudentProfileScreen();
      break;
    case IdCardScreen.route:
      screen = const IdCardScreen();
      break;
    case CourseScreen.route:
      screen = const CourseScreen();
      break;
    case TeachingWorkScreen.route:
      screen = const TeachingWorkScreen();
      break;
    case MaterialScreen.route:
      screen = const MaterialScreen();
      break;
    case TimeTableScreen.route:
      screen = const TimeTableScreen();
      break;
    case NoticeScreen.route:
      screen = const NoticeScreen();
      break;
    case CollegeActivityNotice.route:
      screen = const CollegeActivityNotice();
      break;
    case CompetitiveExamNotice.route:
      screen = const CompetitiveExamNotice();
      break;
    case CulturalFestivalNotice.route:
      screen = const CulturalFestivalNotice();
      break;
    case GeneralNotice.route:
      screen = const GeneralNotice();
      break;
    case JobVacancyNotice.route:
      screen = const JobVacancyNotice();
      break;
    case SportNotice.route:
      screen = const SportNotice();
      break;
    case ResultScreen.route:
      screen = const ResultScreen();
      break;
    case AssignmentScreen.route:
      screen = const AssignmentScreen();
      break;
    case StaffListScreen.route:
      screen = const StaffListScreen();
      break;
    case StaffProfileScreen.route:
      screen = StaffProfileScreen(
        args: arguments,
      );
      break;
  }
  switch (routeType) {
    case RouteType.fade:
      return FadeRoute(
        builder: (_) => screen!,
        settings: RouteSettings(name: routeName),
      );
    case RouteType.left:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.left,
      );

    case RouteType.down:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.down,
      );
    case RouteType.up:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.up,
      );
    case RouteType.right:
      return SlideRoute(
        enterPage: screen!,
        direction: AxisDirection.right,
      );

    case RouteType.defaultRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => screen!,
        settings: RouteSettings(name: routeName),
      );
  }
}
