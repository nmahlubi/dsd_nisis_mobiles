import 'dart:async';

import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_education.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_socialServies/access_to_social_services.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_access_to_vitalRegistration/access_to_vital_registration.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_household_level_questions/level_asks_questions.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_household_particulars.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_skills_employment_and_smallBusiness/skills_employment_and_small_business.dart';
import 'package:dsd_nisis_mobile/pages/dashboard/pages/questionnaire/questionaire_sections/section_social_participants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/household/house_dto.dart';
import '../../../../widget/camera_picker.dart';
import '../../../../widget/image_picker.dart';
import '../../../../widget/textfield_dropdown.dart';
import '../house_hold/house_hold_details.dart';

class HouseHoldQuestionnaire extends StatefulWidget {
  const HouseHoldQuestionnaire({super.key});

  @override
  State<HouseHoldQuestionnaire> createState() => _HouseHoldQuestionnaireState();
}

class _HouseHoldQuestionnaireState extends State<HouseHoldQuestionnaire> {
  late final HouseHoldDto houseHoldDto;
  @override
  int secondsElapsed = 0;
  late Timer timer;
  bool isTimerRunning = false;
  FocusNode _focus = FocusNode();
  bool _isValidate = true;
  SharedPreferences? preferences;
  final TextEditingController _Textcontroller = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = picked.toString();
      });
    }
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializePreference().whenComplete(() {
        setState(() {

        });
      });
    });
  }

  void startTimer() {
    // Set up a timer to increment the secondsElapsed every second
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!isTimerRunning) {
        t.cancel(); // Stop the timer when isTimerRunning is false
      } else {
        setState(() {
          secondsElapsed++;
        });
      }
    });
  }

  void stopTimer() {
    setState(() {
      isTimerRunning = false;
    });
  }

  void resetTimer() {
    setState(() {
      secondsElapsed = 0;
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer.cancel();
    super.dispose();
  }

  showDialogMessage(String? message) {
    final messageDialog = ScaffoldMessenger.of(context);
    messageDialog.showSnackBar(
      SnackBar(content: Text(message!), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFE3C263),
            elevation: 0,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                Text(
                  'Module > Nisis',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://cdn.contactcenterworld.com/images/company/department-of-social-development-1200px-logo.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HouseholdDetails(data: {}, requestData: {},)),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      const Color(
                                          0xFFE3C263) // Adjusted to provided blue color
                                  ),
                                  foregroundColor: MaterialStateProperty.all<Color>(
                                      Colors.black // Adjusted text color to white
                                  ),
                                ),
                                child: const Text('Back'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 100.0),
                                    child: Text(
                                      'Logged in as: ${preferences?.getString('firstname')}',
                                      style: const TextStyle(
                                          fontSize: 7.0, color: Colors.black87),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 100.0),
                                    child: const Text(
                                      'Role: CDP',
                                      style: TextStyle(
                                          fontSize: 7.0, color: Colors.black87),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 100.0),
                                    child: const Text(
                                      'Date:08/08/2023 11:43AM',
                                      style: TextStyle(
                                          fontSize: 7.0, color: Colors.black87),
                                    ),
                                  ),
                                ],
                              ),
                              const CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Color(
                                    0xFF036FE3), // Adjusted to provided blue color
                                child: Text(
                                  'PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                           Column(
                            children: [
                              Center(
                                child: Text(
                                  'Questionnaire',
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                          0xFFE3C263) // Adjusted to provided color
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: double.infinity,
                                        height: 30,
                                        color: Colors.brown[100],
                                        child: const Center(
                                            child: Text(
                                              'Questionnaire',
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('House Member'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Name Jane'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Surname Makubela'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Gender Male'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('Age 40'),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                             Container(
                               color: Colors.brown[50],
                               child:  Column(children: [
                                 Column(children: [
                                   SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                          Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             const Text('Interview Session Time Duration',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const SizedBox(height: 10.0),
                                             Text(
                                               'Start New Interview Timer $secondsElapsed seconds',
                                               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                             ),
                                            // Text('Start New Interview Timer',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const SizedBox(height: 10.0),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0)
                                               ],
                                             ),
                                             const SizedBox(height: 10.0),
                                           ],
                                         ),
                                         Align(
                                            alignment: Alignment.centerRight,
                                           child: Container(
                                             height: 100,
                                             padding:  EdgeInsets.all(4),
                                             child:  VerticalDivider(
                                               color: Colors.brown[50],
                                               thickness: 1,
                                               indent: 20,
                                               endIndent: 0,
                                               width: 5,
                                             ),
                                           ),
                                         ),
                                         Expanded(
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.end,
                                             crossAxisAlignment: CrossAxisAlignment.end,
                                             children: [
                                               ElevatedButton(
                                                 style: ButtonStyle(
                                                   backgroundColor:
                                                   MaterialStateProperty.all<Color>(
                                                       Colors.blue),
                                                   minimumSize: MaterialStateProperty.all<Size>(
                                                     const Size(100, 40),
                                                   ), // Set button width and height
                                                 ),
                                                 onPressed: () {
                                                   setState(() {
                                                     isTimerRunning = true;
                                                   });
                                                   startTimer();
                                                 },
                                                 child: const Row(
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     Text('Start'),
                                                     SizedBox(width: 4)
                                                   ],
                                                 ),
                                               ),
                                               const SizedBox(height: 2.0),
                                               ElevatedButton(
                                                 style: ButtonStyle(
                                                   backgroundColor:
                                                   MaterialStateProperty.all<Color>(
                                                       Colors.blue),
                                                   minimumSize: MaterialStateProperty.all<Size>(
                                                     const Size(100, 40),
                                                   ), // Set button width and height
                                                 ),
                                                 onPressed: stopTimer,
                                                 child: const Row(
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     Text('Stop'),
                                                     SizedBox(width: 4),

                                                   ],
                                                 ),
                                               ),
                                               const SizedBox(height: 2.0),
                                               ElevatedButton(
                                                 style: ButtonStyle(
                                                   backgroundColor:
                                                   MaterialStateProperty.all<Color>(
                                                       Colors.blue),
                                                   minimumSize: MaterialStateProperty.all<Size>(
                                                     const Size(100, 40),
                                                   ), // Set button width and height
                                                 ),
                                                 onPressed: resetTimer,
                                                 child: const Row(
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     Text('Reset'),
                                                     SizedBox(width: 4),
                                                   ],
                                                 ),
                                               ),
                                               const SizedBox(height: 2.0),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                          Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 2',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.person,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Particulars of each person in the household',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                               ElevatedButton(
                                                 style: ButtonStyle(
                                                   backgroundColor:
                                                   MaterialStateProperty.all<Color>(
                                                       Colors.blue[100]!),
                                                   minimumSize: MaterialStateProperty.all<Size>(
                                                     const Size(100, 40),
                                                   ), // Set button width and height
                                                 ),
                                                 onPressed: () {},
                                                 child: const Row(
                                                   mainAxisSize: MainAxisSize.min,
                                                   children: <Widget>[
                                                     SizedBox(width: 8),
                                                     Text('Completed'),
                                                   ],
                                                 ),
                                               ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => SectionHouseholdParticulars()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                   SizedBox(width: 4),
                                                   Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                             ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 3',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.sports_handball,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Social participation involves in social groups,\n organization, other activities and clubs',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),

                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => SectionSocialParticipants()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 4',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.menu_book,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Access to educational services',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('In progress'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => SectionAccessToEducation()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 5',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.monitor_heart,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Access to health',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 6',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.front_hand_outlined,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Access to Social Service',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => AccessToSocialServices(message: '',)),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => AccessToSocialServices(message: '',)),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 7',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.person_outline,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Access to Vital registration(Home Affairs',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => AccessToVitalRegistration()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 8',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.clean_hands_rounded,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('Skills,Employment and Small business',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => SkillsEmploymentAndSmallBusiness()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('Section 9',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.family_restroom_outlined,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('This section asks household level questions',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {
                                                     Navigator.push(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => LevelAsksQuestions()),
                                                     );
                                                   },
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   const Divider(
                                     thickness: 2,
                                     color: Colors.grey,
                                   ),
                                   const SizedBox(height: 10.0),
                                   Center(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             ElevatedButton(
                                               style: ButtonStyle(
                                                 backgroundColor:
                                                 MaterialStateProperty.all<Color>(
                                                     Colors.brown[50]!),
                                                 minimumSize: MaterialStateProperty.all<Size>(
                                                   Size(100, 40),
                                                 ), // Set button width and height
                                               ),
                                               onPressed: () {},
                                               child:  const Row(
                                                 mainAxisSize: MainAxisSize.min,
                                                 children: <Widget>[
                                                   Text('SECTION 1',style: TextStyle(color: Colors.black), ),
                                                   Icon(Icons.star_border,color: Colors.black),
                                                 ],
                                               ),
                                             ),
                                             const Text('This section asks household level questions',style:
                                             TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0),),
                                             const Row(
                                               children: [
                                                 Text('Help Instruction',style:
                                                 TextStyle(fontWeight: FontWeight.bold,fontSize: 10.0),),
                                                 Icon(Icons.info,size: 15.0),
                                               ],
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('Completed'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue[100]!),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       SizedBox(width: 8),
                                                       Text('QA Review'),
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5.0),
                                                 ElevatedButton(
                                                   style: ButtonStyle(
                                                     backgroundColor:
                                                     MaterialStateProperty.all<Color>(
                                                         Colors.blue),
                                                     minimumSize: MaterialStateProperty.all<Size>(
                                                       const Size(100, 40),
                                                     ), // Set button width and height
                                                   ),
                                                   onPressed: () {},
                                                   child: const Row(
                                                     mainAxisSize: MainAxisSize.min,
                                                     children: <Widget>[
                                                       Text('Edit'),
                                                       SizedBox(width: 4),
                                                       Icon(Icons.edit)
                                                     ],
                                                   ),
                                                 ),
                                                 const SizedBox(width: 10.0),
                                               ],)
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 50.0),
                                 ],)
                               ]),
                             )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Log Out',
              ),
            ],
          ),
        ));
  }

  _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 2000),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Hai This Is Full Screen Dialog',
                    style: TextStyle(color: Colors.red, fontSize: 20.0),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(100, 50),
                      ), // Set button width and height
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: 8),
                        Text('Dismiss'),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'House Image',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE3C263) // Adjusted to provided color
              ),
            ),
          ),
          content: SizedBox(
            height: 180,
            width: 200,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(200, 50),
                    ), // Set button width and height
                  ),
                  onPressed: () {

                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 8),
                      Text('Use Camera'),
                      SizedBox(width: 4),
                      Icon(Icons.camera),
                    ],
                  ),
                ),
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 36,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        height: 36,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(200, 50),
                    ), // Set button width and height
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageFromGalleryEx(AlertDialog)),
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 8),
                      Text('Upload Image'),
                      SizedBox(width: 4),
                      Icon(Icons.upload),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showCustomDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Column(
            children: [
              Center(
                child: Text(
                  'Image Description',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE3C263) // Adjusted to provided color
                  ),
                ),
              ),
              Divider(thickness: 2, color: Colors.grey, endIndent: 10),
            ],
          ),
          content: SizedBox(
            height: 180,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (_Textcontroller.value.text.isEmpty)
                    ? const Text("Image description")
                    : Text('Sent Message: ${_Textcontroller.value.text}'),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller: _Textcontroller,
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Enter A Message Here',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all<Size>(
                          const Size(100, 50),
                        ), // Set button width and height
                      ),
                      onPressed: () {

                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(width: 8),
                          Text('Save'),
                          SizedBox(width: 4),
                          Icon(Icons.save),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: const Color(0x802196F3),
        child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
              //print('Not set yet');
            },
            child: child));
  }
}
