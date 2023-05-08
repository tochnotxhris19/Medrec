import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/global.dart';
import 'package:notes_app/screens/login.dart';

import '../controller/auth_controller.dart';
import '../notes_services.dart';

class AddRecordPage extends ConsumerStatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends ConsumerState<AddRecordPage> {
  TextEditingController feeController = TextEditingController();
  TextEditingController patientAddress = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController vitals = TextEditingController();
  TextEditingController medicines = TextEditingController();
  TextEditingController advice = TextEditingController();
  TextEditingController patient = TextEditingController();
  bool isAuthorized = false;
  bool showLoading = false;

  @override
  void initState() {
    //   getFee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notesServices = ref.watch(notesServiceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height / 8,
                // padding: const EdgeInsets.all(8),
                // decoration: const BoxDecoration(
                //   color: Colors.grey,
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(0),
                //     bottomLeft: Radius.circular(50),
                //     topRight: Radius.circular(0),
                //     bottomRight: Radius.circular(50),
                //   ),
                // ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      FontAwesomeIcons.userDoctor,
                      color: Colors.black,
                      size: 40,
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      // thickness: 5,
                    ),
                    Text(
                      'Add Record Panel',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: MediaQuery.of(context).size.width * 0.7,
              //         padding: const EdgeInsets.all(16),
              //         decoration: BoxDecoration(
              //           color: Colors.green.shade50,
              //           borderRadius: BorderRadius.circular(20),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey.withOpacity(0.5),
              //               blurRadius: 7,
              //               offset: const Offset(
              //                   0, 3), // changes position of shadow
              //             ),
              //           ],
              //         ),
              //         child: Center(
              //           child: Text(
              //             "Connector $globalPrivateKey",
              //             style: TextStyle(
              //                 fontSize:
              //                     (MediaQuery.of(context).size.width * 0.02),
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.green),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       InkWell(
              //         onTap: () {
              //           Navigator.pushAndRemoveUntil(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => LoginPage()),
              //               (route) => false);
              //         },
              //         child: Container(
              //           width: MediaQuery.of(context).size.width * 0.2,
              //           padding: const EdgeInsets.all(16),
              //           decoration: BoxDecoration(
              //             color: Colors.red.shade50,
              //             borderRadius: BorderRadius.circular(20),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.5),
              //                 blurRadius: 7,
              //                 offset: const Offset(
              //                     0, 3), // changes position of shadow
              //               ),
              //             ],
              //           ),
              //           child: Center(
              //             child: Text(
              //               "Logout",
              //               style: TextStyle(
              //                   fontSize:
              //                       (MediaQuery.of(context).size.width * 0.02),
              //                   // fontWeight: FontWeight.bold,
              //                   color: Colors.red),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              showLoading == false
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 200,
                                height: 50,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.ethereum,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1,
                                    ),
                                    Text(
                                      'Update Fee',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CupertinoFormSection(
                                children: [
                                  CupertinoTextFormFieldRow(
                                    style: GoogleFonts.poppins(),
                                    controller: patient,
                                    onTap: _showPatients,
                                    placeholder: "Tap to Show Patients",
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Patients can't be empty";
                                      }
                                      return null;
                                    },
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    prefix: Text(
                                      "Patient         ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    readOnly: true,
                                  ),
                                  CupertinoFormRow(
                                    child: CupertinoTextFormFieldRow(
                                      controller: feeController,
                                      placeholder: "Change Fee",
                                      padding: const EdgeInsets.only(left: 0),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Fee cannot be empty.";
                                        }
                                        return null;
                                      },
                                      enableSuggestions: true,
                                      prefix: Text(
                                        'Fee (In \€)  | ',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                // updateFee(feeController.text),
                                child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        'Update',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: null,
                      ),
                    ),
              showLoading == false
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                // width: 250,
                                height: 50,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.prescriptionBottle,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: VerticalDivider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                    ),
                                    Text(
                                      'Give Prescription',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CupertinoFormSection(
                                children: [
                                  CupertinoFormRow(
                                    child: CupertinoTextFormFieldRow(
                                      controller: patientAddress,
                                      placeholder: "Patient Address",
                                      padding: const EdgeInsets.only(left: 0),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Address cannot be empty.";
                                        }
                                        return null;
                                      },
                                      prefix: Text(
                                        'Address  | ',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  CupertinoFormSection(
                                    children: [
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          controller: notes,
                                          // placeholder: "Notes",
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Notes cannot be empty.";
                                            }
                                            return null;
                                          },
                                          prefix: Text(
                                            'Notes  | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          expands: true,
                                          maxLength: null,
                                          maxLines: null,
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          controller: vitals,
                                          // placeholder: "Vitals",
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Vitals cannot be empty.";
                                            }
                                            return null;
                                          },
                                          prefix: Text(
                                            'Vitals  | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          expands: true,
                                          maxLength: null,
                                          maxLines: null,
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          controller: medicines,
                                          // placeholder: "Patient Address",
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Medicines cannot be empty.";
                                            }
                                            return null;
                                          },
                                          prefix: Text(
                                            'Medicines  | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          expands: true,
                                          maxLength: null,
                                          maxLines: null,
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          controller: advice,
                                          // placeholder: "Advice Address",
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Advice cannot be empty.";
                                            }
                                            return null;
                                          },
                                          prefix: Text(
                                            'Advice  | ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          expands: true,
                                          maxLength: null,
                                          maxLines: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 16),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showLoading = true;
                                          });
                                          notesServices.addNote(
                                              feeController.text.toString(),
                                              patientAddress.text,
                                              notes.text,
                                              vitals.text,
                                              medicines.text,
                                              advice.text);
                                          Navigator.pop(context);
                                          setState(() {
                                            showLoading = false;
                                          });
                                        },
                                        //sendPrescription(),
                                        child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 7,
                                                  offset: const Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Send',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CupertinoActivityIndicator(
                          radius: 20,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  _showPatients() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Consumer(builder: (context, ref, child) {
              final doctorsProvider = ref.watch(patientsController);
              return Wrap(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Text(
                      "Patients",
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
                                  patient.text = data[index].name ?? "";
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
