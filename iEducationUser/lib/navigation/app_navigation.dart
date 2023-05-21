import 'package:user/common/pref_util.dart';
import 'package:user/login_screen.dart';
import 'package:user/navigation/constants.dart';
import 'package:user/navigation/navigator.dart';
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
import 'package:user/utils.dart';

class AppNavigation {
  static final AppNavigation shared = AppNavigation();

  goNextFromSplash() async {
    DateTime currentDate = DateTime.now();
    if (SharedPref.getIsScanned != null) {
      if (!(currentDate
          .isSameDate(DateTime.parse(SharedPref.getScannedDate!)))) {
        SharedPref.setIsScanned = false;
      }
    }
    if (SharedPref.getMobileNumber != null) {
      await NavigationUtilities.pushReplacementNamed(HomeScreenBottomBar.route,
          type: RouteType.up);
    } else {
      await NavigationUtilities.pushReplacementNamed(LoginScreen.route,
          type: RouteType.right);
    }
  }

  void movetoStudentProfileScreen() {
    NavigationUtilities.pushNamed(StudentProfileScreen.route,
        type: RouteType.left);
  }

  void moveToQrScreen() {
    NavigationUtilities.pushReplacementNamed(QrScannerScreen.route,
        type: RouteType.up);
  }

  void movetoStudentIDCard() {
    NavigationUtilities.pushNamed(IdCardScreen.route, type: RouteType.up);
  }

  void movetoCourseScreen() {
    NavigationUtilities.pushNamed(CourseScreen.route, type: RouteType.up);
  }

  void movetoTeachingWork() {
    NavigationUtilities.pushNamed(TeachingWorkScreen.route, type: RouteType.up);
  }

  void movetoMaterialScreen() {
    NavigationUtilities.pushNamed(MaterialScreen.route, type: RouteType.up);
  }

  void movetoTimeTableScreen() {
    NavigationUtilities.pushNamed(TimeTableScreen.route, type: RouteType.up);
  }

  void movetoNoticeScreen() {
    NavigationUtilities.pushNamed(NoticeScreen.route, type: RouteType.up);
  }

  void movetoCollegeActivityNotice() {
    NavigationUtilities.pushNamed(CollegeActivityNotice.route,
        type: RouteType.up);
  }

  void movetoCompatitiveExamNotice() {
    NavigationUtilities.pushNamed(CompetitiveExamNotice.route,
        type: RouteType.up);
  }

  void movetoCulturalFestivalNotice() {
    NavigationUtilities.pushNamed(CulturalFestivalNotice.route,
        type: RouteType.up);
  }

  void movetoGeneralNotice() {
    NavigationUtilities.pushNamed(GeneralNotice.route, type: RouteType.up);
  }

  void movetoJobVacancynotice() {
    NavigationUtilities.pushNamed(JobVacancyNotice.route, type: RouteType.up);
  }

  void movetoSportsNotice() {
    NavigationUtilities.pushNamed(SportNotice.route, type: RouteType.up);
  }

  void movetoResultScreen() {
    NavigationUtilities.pushNamed(ResultScreen.route, type: RouteType.up);
  }

  void movetoAssignmentScreen() {
    NavigationUtilities.pushNamed(AssignmentScreen.route, type: RouteType.up);
  }

  void movetoStaffListcreen() {
    NavigationUtilities.pushNamed(StaffListScreen.route, type: RouteType.up);
  }

  void movetoStaffProfilecreen(Map<String, dynamic> args) async {
    await NavigationUtilities.pushNamed(StaffProfileScreen.route,
        type: RouteType.up, args: args);
  }
}
