import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:user/database/database_model.dart';

// **** Student ****
class StudentDataApi {
  static List<Student> studentDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('studentDetails');

  static fetchData() async {
    studentDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        value.forEach((key, value) {
          studentDataList.add(Student.fromJson(value));
        });
        studentDataList.sort((a, b) => a.key.compareTo(b.key));
      });
    });
  }
}

// **** Staff List ****
class StaffListApi {
  static List<StaffList> staffDataList = [];

  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('staffList');

  static Future fetchData() async {
    staffDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        staffDataList.add(StaffList.fromJson(value));
      });
      staffDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Time Table ****
class TimeTableApi {
  static List<TimeTableModel> timeTableDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('timeTable');

  static fetchData() async {
    timeTableDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        List<TimeTable> temp = [];
        value.forEach((key, value) {
          Map data = value as Map<dynamic, dynamic>;
          temp.add(TimeTable.fromJson(data));
        });
        Map tempMap = {
          'lectureDate': key,
          'tb': List<Map<String, dynamic>>.from(temp.map((e) => e.toJson())),
        };
        timeTableDataList.add(TimeTableModel.fromJson(tempMap));
      });
    });
  }
}

// **** Materials ****
class MaterialApi {
  static List<Materials> materialsDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('materials');

  static Future fetchData() async {
    materialsDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        materialsDataList.add(Materials.fromJson(value));
      });
      materialsDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Assignment ****
class AssignmentApi {
  static List<Assignment> assignmentDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('assignments');

  static Future fetchData() async {
    assignmentDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        assignmentDataList.add(Assignment.fromJson(value));
      });
      assignmentDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Course ****
class CourseApi {
  static List<Course> courseDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('courses');

  static fetchData() async {
    courseDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        courseDataList.add(Course.fromJson(value));
      });
      courseDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Result ****
class ResultApi {
  static List<Result> resultDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('results');

  static Future<void> fetchData() async {
    resultDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        resultDataList.add(Result.fromJson(value));
      });
      resultDataList.sort((a, b) => a.key!.compareTo(b.key!));
    });
  }
}

// **** Cultural Festival Notice ****
class CulturalFestivalApi {
  static List<CulturalFestival> culturalFestivalDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('culturalFestivalNotice');

  static fetchData() async {
    culturalFestivalDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        culturalFestivalDataList.add(CulturalFestival.fromJson(value));
      });
      culturalFestivalDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** College Activity Notice ****

class CollegeActivityApi {
  static List<CollegeActivity> collegeActivityDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('collegeActivityNotice');

  static fetchData() async {
    collegeActivityDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        collegeActivityDataList.add(CollegeActivity.fromJson(value));
      });
      collegeActivityDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Sports Notice ****
class SportsApi {
  static List<Sports> sportsDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('sportsNotice');

  static fetchData() async {
    sportsDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        sportsDataList.add(Sports.fromJson(value));
      });
      sportsDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Job Vacancy Notice ****
class JobVacancyApi {
  static List<JobVacancy> jobVacancyDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('jobVacancyNotice');

  static fetchData() async {
    jobVacancyDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        jobVacancyDataList.add(JobVacancy.fromJson(value));
      });
      jobVacancyDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** General Notice ****
class GeneralApi {
  static List<General> generalDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('generalNotice');

  static fetchData() async {
    generalDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        generalDataList.add(General.fromJson(value));
      });
      generalDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

// **** Compatitive Exam Notice ****
class CompetitiveExamApi {
  static List<CompetitiveExam> competitiveExamDataList = [];
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('competitiveExamNotice');

  static fetchData() async {
    competitiveExamDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        competitiveExamDataList.add(CompetitiveExam.fromJson(value));
      });
      competitiveExamDataList.sort((a, b) => a.key.compareTo(b.key));
    });
  }
}

class AttendenceApi {
  static DatabaseReference db = FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: 'https://ieducation-bdbea-default-rtdb.firebaseio.com')
      .ref('attendence');
  static List<Attendence> attendenceDataList = [];
  static attendenceAddData({required Attendence obj}) async {
    await db
        .child(obj.stream.toString())
        .child(obj.key.toString())
        .set(obj.toJson());
  }

  static fetchData() async {
    attendenceDataList.clear();
    await db.once().then((value) {
      Map data =
          value.snapshot.value == null ? {} : value.snapshot.value as Map;
      data.forEach((key, value) {
        value.forEach((key, value) {
          attendenceDataList.add(Attendence.fromJson(value));
        });
      });
    });
  }

  static attendenceUpdateData({required Attendence obj}) async {
    await db
        .child(obj.stream.toString())
        .child(obj.key.toString())
        .set(obj.toJson());
  }
}
