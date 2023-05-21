import 'dart:collection';

class UserData {
  final String? key;
  final String? mobilNumber;
  final String? password;

  UserData({
    this.key,
    required this.mobilNumber,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        key: json["key"],
        mobilNumber: json["mobilNumber"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = HashMap();
    if (key != null) {
      data["key"] = key;
    }
    if (mobilNumber != null) {
      data["mobilNumber"] = mobilNumber;
    }
    if (password != null) {
      data["password"] = password;
    }
    return data;
  }
}
