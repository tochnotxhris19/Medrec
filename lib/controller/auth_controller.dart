import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/login.dart';

import '../../../../core/provider/is_internet_connected_provider.dart';
import '../api/auth_api_service.dart';
import '../home_screen.dart';
import '../screens/bottom_bar_screen.dart';
import '../screens/doctor_home_page.dart';

final doctorsController = FutureProvider.autoDispose((ref) {
  final authAPI = ref.watch(authAPIProvider);
  return authAPI.getDoctors();
});
final patientsController = FutureProvider.autoDispose((ref) {
  final authAPI = ref.watch(authAPIProvider);
  return authAPI.getPatients();
});

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, bool>((ref) {
  final connectivity = ref.watch(isInternetConnectedProvider);
  final authAPI = ref.watch(authAPIProvider);
  return AuthController(authAPI: authAPI, connectivity: connectivity);
});

class AuthController extends StateNotifier<bool> {
  AuthController(
      {required AuthAPI authAPI,
      required InternetConnectionObserver connectivity})
      : _authAPI = authAPI,
        _connectivity = connectivity,
        super(false);
  final AuthAPI _authAPI;
  final InternetConnectionObserver _connectivity;
  void register(
      {required String email,
      required String password,
      required String role,
      required String doctor,
      required String location,
      required String name,
      required BuildContext context}) async {
    final connection = await _connectivity.isNetConnected();
    if (connection) {
      state = true;
      final res = await _authAPI.register(
          location: location,
          role: role,
          email: email,
          password: password,
          doctor: doctor,
          name: name);

      state = false;
      res.fold((l) {
        Fluttertoast.showToast(msg: l.message, backgroundColor: Colors.red);
      }, (r) {
        Fluttertoast.showToast(msg: "Registration successful");
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      });
    } else {
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          // ignore: use_build_context_synchronously
          backgroundColor: Theme.of(context).colorScheme.error);
    }
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final connection = await _connectivity.isNetConnected();
    if (connection) {
      state = true;
      final res = await _authAPI.login(email: email, password: password);

      state = false;

      res.fold((l) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(l.message,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.red)),
                  Text("Please Contact info@medrec.com for assistance",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () async {
                                Navigator.pop(context);
                                //context.pop();
                              },
                              child: const Text(
                                "Okay",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      }, (r) async {
        Fluttertoast.showToast(
            msg: "Welcome back ${r.user!.email}",
            backgroundColor: Theme.of(context).colorScheme.primary);
        if (r.user!.role == "Patient") {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientScreen(),
              ));
        } else if (r.user!.role == "Doctor") {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminScreen(),
              ));
        }
        // context.goNamed(AppRoute.otp.name, extra: r);
      });
    } else {
      Fluttertoast.showToast(
          msg: "No Internet Connection",
          backgroundColor: Theme.of(context).colorScheme.error);
    }
  }
}
