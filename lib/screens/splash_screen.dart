import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/home_screen.dart';

import '../core/local/auth_service.dart';
import 'bottom_bar_screen.dart';
import 'doctor_home_page.dart';
import 'login.dart';

class Splash2 extends StatefulWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    bool found = await AuthService.instance.load();
    if (!found) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginPage())));
    } else {
      if (AuthService.instance.authUser!.user!.role == "Patient") {
        Timer(
            const Duration(seconds: 3),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientScreen(),
                )));
      } else if (AuthService.instance.authUser!.user!.role == "Doctor") {
        Timer(
            const Duration(seconds: 3),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminScreen(),
                )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(500),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 50,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.asset(
                    'assets/Icons/1024.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "M E D R E C",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              "Manage Your Medical Records",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
