import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/home_screen.dart';

import '../controller/auth_controller.dart';
import '../global.dart';
import 'doctor_home_page.dart';
import 'login.dart';

bool adding = false;

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController doctor = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController role = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  _showPicker() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Text(
                    "Roles",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                    leading: const Icon(
                      CupertinoIcons.person_alt_circle,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Patient',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      role.text = "Patient";
                      setState(() {});
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'Doctor',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      role.text = "Doctor";
                      setState(() {});
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        });
  }

  void moveToHome() async {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).register(
          context: context,
          location: location.text,
          name: name.text,
          email: email.text,
          password: password.text,
          doctor: doctor.text,
          role: role.text);
      //   adding = true;
      //   setState(() {});
      //   if (role.text == "Patient") {
      //     setState(() {
      //       // privateKey.text =
      //       //     "03a6cd230f000754daf6a2cef9b3bd1d726be32a0c482dc23544c8f4eb245c2c";
      //       globalPrivateKey =
      //           "03a6cd230f000754daf6a2cef9b3bd1d726be32a0c482dc23544c8f4eb245c2c";
      //     });
      //     await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => PatientScreen(),
      //         ));
      //     adding = false;
      //   } else if (role.text == "Doctor") {
      //     setState(() {
      //       // privateKey.text =
      //       //     "03a6cd230f000754daf6a2cef9b3bd1d726be32a0c482dc23544c8f4eb245c2c";
      //       globalPrivateKey =
      //           "03a6cd230f000754daf6a2cef9b3bd1d726be32a0c482dc23544c8f4eb245c2c";
      //     });
      //     await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => DoctorsScreen(),
      //         ));
      //     adding = false;
      //   }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loginState = ref.watch(authControllerProvider);
    return Material(
      color: Theme.of(context).canvasColor,
      child: Scaffold(
        body: SafeArea(
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
                          "Sign-Up",
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
                                controller: name,
                                placeholder: "Enter your name",
                                enabled: true,
                                prefix: Text(
                                  "Name          ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Name can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                style: GoogleFonts.poppins(),
                                controller: email,
                                placeholder: "Enter your email",
                                enabled: true,
                                prefix: Text(
                                  "Email          ",
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
                            CupertinoTextFormFieldRow(
                              style: GoogleFonts.poppins(),
                              controller: role,
                              onTap: _showPicker,
                              placeholder: "Tap to Show Roles",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Role can't be empty";
                                }
                                return null;
                              },
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              prefix: Text(
                                "Role             ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              readOnly: true,
                            ),
                            role.text == "Patient"
                                ? CupertinoTextFormFieldRow(
                                    style: GoogleFonts.poppins(),
                                    controller: doctor,
                                    onTap: _showDoctors,
                                    placeholder: "Tap to Show Doctors",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Doctor can't be empty";
                                      }
                                      return null;
                                    },
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    prefix: Text(
                                      "Doctor         ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    readOnly: true,
                                  )
                                : SizedBox.shrink(),
                            role.text == "Doctor"
                                ? CupertinoFormRow(
                                    //padding: EdgeInsets.only(left: 0),
                                    child: CupertinoTextFormFieldRow(
                                      style: GoogleFonts.poppins(),
                                      controller: location,
                                      placeholder: "Enter your Location",
                                      enabled: true,
                                      prefix: Text(
                                        "Location      ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      padding: const EdgeInsets.only(left: 0),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "location can't be empty";
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                : SizedBox.shrink(),
                            CupertinoFormRow(
                              //padding: EdgeInsets.only(left: 0),
                              child: CupertinoTextFormFieldRow(
                                style: GoogleFonts.poppins(),
                                controller: password,
                                placeholder: "Enter your password",
                                enabled: true,
                                obscureText: obscureText,
                                prefix: Text(
                                  "Password      ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                padding: const EdgeInsets.only(left: 0),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "password can't be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
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
                                    'Sign Up',
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
                          const Text(
                            "Have an account ?",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
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
        ),
      ),
    );
  }

  _showDoctors() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Consumer(builder: (context, ref, child) {
              final doctorsProvider = ref.watch(doctorsController);
              return Wrap(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Text(
                      "Doctors",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),

                  doctorsProvider.when(data: (data) {
                    return Container(
                      height: 400,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: const Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  data[index].name ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  doctor.text = data[index].name ?? "";
                                  setState(() {});
                                  Navigator.pop(context);
                                });
                          }),
                    );
                  }, error: (error, s) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  }, loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                  // ListTile(
                  //     leading: const Icon(
                  //       CupertinoIcons.person_alt_circle,
                  //       color: Colors.black,
                  //     ),
                  //     title: const Text(
                  //       'Patient',
                  //       style:
                  //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //     ),
                  //     onTap: () {
                  //       role.text = "Patient";
                  //       setState(() {});
                  //       Navigator.pop(context);
                  //     }),
                  // ListTile(
                  //     leading: const Icon(
                  //       FontAwesomeIcons.userDoctor,
                  //       color: Colors.black,
                  //     ),
                  //     title: const Text(
                  //       'Doctor',
                  //       style:
                  //           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  //     ),
                  //     onTap: () {
                  //       role.text = "Doctor";
                  //       setState(() {});
                  //       Navigator.pop(context);
                  //     })
                ],
              );
            }),
          );
        });
  }
}
