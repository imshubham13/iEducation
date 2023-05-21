import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/common/textfields.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/navigation/app_navigation.dart';
import 'package:user/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _passwordVisible = true;
  bool isLoginLoader = false;
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  getLoginData() async {
    isLoginLoader = true;
    await DataBaseHelper.loginData();

    setState(() {});
    isLoginLoader = false;
  }

  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Press Again to Exit',
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromRGBO(91, 62, 144, 0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
        behavior: SnackBarBehavior.floating,
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: background,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            'assets/images/ieducation.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        textField(
                          controller: mobileNumber,
                          lableText: 'Mobile Number',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        textField(
                            controller: password,
                            lableText: 'Password',
                            prefixIcon: Icons.lock,
                            obscureText: _passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            suffixIcon: _passwordVisible
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_outlined,
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            }),
                        const SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool isLogin = false;
                              for (var element in DataBaseHelper.userDataList) {
                                if (element.mobilNumber == mobileNumber.text &&
                                    element.password == password.text) {
                                  SharedPref.setMobileNumber =
                                      mobileNumber.text;
                                  AppNavigation.shared.goNextFromSplash();
                                  isLogin = true;
                                }
                              }
                              if (isLogin == false) {
                                if (DataBaseHelper.userDataList.any((element) =>
                                    element.mobilNumber == mobileNumber.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Wrong password",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      backgroundColor: Colors.red[200],
                                      margin: const EdgeInsets.all(20),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Invalid mobile Number",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      backgroundColor: Colors.red[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.all(20),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                              //     if (DataBaseHelper.userDataList.any((element) =>
                              //         element.mobilNumber == mobileNumber.text)) {
                              //       if (DataBaseHelper.userDataList.any((element) =>
                              //           element.password == password.text)) {
                              //         SharedPref.setMobileNumber =
                              //             mobileNumber.text;
                              //         AppNavigation.shared.goNextFromSplash();
                              //       } else {
                              //         ScaffoldMessenger.of(context).showSnackBar(
                              //           SnackBar(
                              //             content: const Align(
                              //               alignment: Alignment.center,
                              //               child: Text(
                              //                 "Wrong password",
                              //                 style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //             ),
                              //             backgroundColor: Colors.red[200],
                              //             margin: const EdgeInsets.all(20),
                              //             behavior: SnackBarBehavior.floating,
                              //             shape: RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.circular(20),
                              //             ),
                              //           ),
                              //         );
                              //       }
                              //     } else {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(
                              //           content: const Align(
                              //             alignment: Alignment.center,
                              //             child: Text(
                              //               "Invalid mobile Number",
                              //               style: TextStyle(
                              //                   color: Colors.white,
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ),
                              //           backgroundColor: Colors.red[200],
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(20),
                              //           ),
                              //           margin: const EdgeInsets.all(20),
                              //           behavior: SnackBarBehavior.floating,
                              //         ),
                              //       );
                              //     }
                            }
                          },
                          minWidth: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.065,
                          color: primarycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Account not found? ',
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: TextStyle(
                                    color: primarycolor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
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
