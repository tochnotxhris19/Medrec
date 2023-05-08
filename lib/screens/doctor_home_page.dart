// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/global.dart';
import 'package:notes_app/notes_services.dart';
import 'package:notes_app/screens/view_prescription.dart';

import '../core/local/auth_service.dart';
import 'add_record.dart';

class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController feeController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    feeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notesServices = ref.watch(notesServiceProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "MedRec",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: notesServices.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {},
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.person_circle,
                                color: Colors.grey,
                                size: 40,
                              ),
                              VerticalDivider(
                                color: Colors.grey,
                                // thickness: 5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello Jane,",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "jane@gmai.com,",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "Date: ${DateFormat.MEd().format(DateTime.now())}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    // Text(
                                    //   'Doctors Panel',
                                    //   style: TextStyle(
                                    //       fontSize: 40,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                FontAwesomeIcons.timeline,
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
                                'Medical History',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      notesServices.notes.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 32.0, left: 16),
                              child: Text(
                                "No Medical History!",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: notesServices.notes.length,
                              itemBuilder: (context, index) {
                                final notes = notesServices.notes[index];
                                return Container(
                                    // margin: EdgeInsets.all(16),
                                    // height: 100,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPrescription(
                                                      notes: notes,
                                                      index: index,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                color: Colors.black,
                                                child: Text(
                                                  "  ${index + 1}  ",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const VerticalDivider(
                                            thickness: 2,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Fee",
                                                    // style:
                                                    //     Theme.of(context).textTheme.caption,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    notes.fee,
                                                    // style:
                                                    //     Theme.of(context).textTheme.caption,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Vitals",
                                                    // style:
                                                    //     Theme.of(context).textTheme.caption,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 200,
                                                    // height: 30,
                                                    child: Text(
                                                      notes.vitals,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        print("Pressed");
                                                        notesServices
                                                            .deleteNote(
                                                                notesServices
                                                                    .notes[
                                                                        index]
                                                                    .id);
                                                      },
                                                      child:
                                                          Icon(Icons.delete)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddRecordPage()));
        },
      ),
    );
  }
}
