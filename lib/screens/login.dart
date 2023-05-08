import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/home_screen.dart';
import 'package:notes_app/screens/signup.dart';

import '../controller/auth_controller.dart';
import '../global.dart';
import 'bottom_bar_screen.dart';
import 'doctor_home_page.dart';

bool adding = false;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController role = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        bool loginState = ref.watch(authControllerProvider);
        return SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Image.asset(
                                "assets/images/welcomeImage.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text(
                          "Sign-In",
                          style: GoogleFonts.lato(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                        child: CupertinoFormSection(
                          backgroundColor: Colors.transparent,
                          children: [
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                style: GoogleFonts.poppins(),
                                controller: email,
                                placeholder: "Enter your email",
                                enabled: true,
                                prefix: Text(
                                  "Email              ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Email can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                style: GoogleFonts.poppins(),
                                controller: password,
                                placeholder: "Enter your password",
                                enabled: true,
                                obscureText: obscureText,
                                prefix: Text(
                                  "password      ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Password can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // CupertinoTextFormFieldRow(
                            //   style: GoogleFonts.poppins(),
                            //   controller: role,
                            //   onTap: _showPicker,
                            //   placeholder: "Tap to Show Roles",
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "Role can't be empty";
                            //     }
                            //     return null;
                            //   },
                            //   decoration: const BoxDecoration(color: Colors.white),
                            //   prefix: Text(
                            //     "Role            ",
                            //     style: Theme.of(context).textTheme.caption,
                            //   ),
                            //   readOnly: true,
                            // ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () async {
                                    moveToHome();
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupPage()));
                              // Navigator.of(context)
                              //     .pushNamed(SignUpPage.routename);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              loginState
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        );
      }),
    );
  }

  void moveToHome() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PatientScreen(),
        ));
    // if (_formKey.currentState!.validate()) {
    //   ref
    //       .read(authControllerProvider.notifier)
    //       .login(context: context, email: email.text, password: password.text);
    // }
  }
}
