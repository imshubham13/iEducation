import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/common/textfields.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/database/database_api.dart';
import 'package:user/login_screen.dart';
import 'package:user/model/model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool _passwordVisible = true;
  bool isSingUpLoading = false;
  bool isLoginLoader = false;

  getLoginData() async {
    isLoginLoader = true;
    setState(() {});
    await DataBaseHelper.loginData();
    await StudentDataApi.fetchData();
    isLoginLoader = false;
  }

  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  final GlobalKey<FormState> singUpFormKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    mobileNumber.clear();
    password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  key: singUpFormKey,
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
                      isSingUpLoading
                          ? const Center(child: CircularProgressIndicator())
                          : MaterialButton(
                              onPressed: () async {
                                if (singUpFormKey.currentState!.validate()) {
                                  UserData userData = UserData(
                                    mobilNumber: mobileNumber.text,
                                    password: password.text,
                                  );
                                  isSingUpLoading = true;
                                  if (StudentDataApi.studentDataList.any(
                                        (element) =>
                                            element.phoneNo ==
                                            mobileNumber.text,
                                      ) &&
                                      DataBaseHelper.userDataList.any(
                                          (element) =>
                                              element.mobilNumber ==
                                              mobileNumber.text)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Mobile number is already registered "),
                                      backgroundColor: Colors.red,
                                      margin: EdgeInsets.all(20),
                                      behavior: SnackBarBehavior.floating,
                                    ));
                                  } else if (StudentDataApi.studentDataList.any(
                                      (element) =>
                                          element.phoneNo ==
                                          mobileNumber.text)) {
                                    await DataBaseHelper.userData(
                                        data: userData.toJson());
                                    DataBaseHelper.clearAllData();
                                    if (!mounted) return;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Student Not Found",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        backgroundColor: Colors.red[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        margin: const EdgeInsets.all(20),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                  isSingUpLoading = false;
                                  setState(() {});
                                }
                              },
                              minWidth: MediaQuery.of(context).size.width * 0.5,
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              color: primarycolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Register',
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            children: [
                              TextSpan(
                                text: 'Login',
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
    );
  }
}
