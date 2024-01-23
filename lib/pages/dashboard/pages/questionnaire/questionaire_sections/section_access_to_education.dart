import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../widget/textfield_dropdown.dart';
import '../house_hold_questionnaire.dart';
enum Quastions { Yes, No, Maybe }
class SectionAccessToEducation extends StatefulWidget {
  const SectionAccessToEducation({super.key});

  @override
  State<SectionAccessToEducation> createState() => _SectionAccessToEducationState();
}

class _SectionAccessToEducationState extends State<SectionAccessToEducation> {
  @override
  Quastions? _quastions = Quastions.Yes;
  FocusNode _focus = FocusNode();
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
        setState(() {});
      });
    });
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
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HouseHoldQuestionnaire()),
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          width: double.infinity,
                                          height: 60,
                                          color: const Color(0xFFE3C263) ,
                                          child:
                                          const Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                    'Questionnaire',
                                                    style:
                                                    TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                                                  )),
                                              Center(
                                                  child: Text(
                                                    'Section 4:Access to educational Services ',
                                                    style:
                                                    TextStyle(fontWeight: FontWeight.bold),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
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
                                          Text('Name Siyabong'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('Surname Mthembu'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('Gender Male'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text('Age 34'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  const Text('4.1 Is...currently attending school or any other \n educational institution?'),
                                  const SizedBox(height: 10.0),
                                  ListTile(
                                    title: const Text('Yes'),
                                    leading: Radio<Quastions>(
                                      value: Quastions.Yes,
                                      groupValue: _quastions,
                                      onChanged: (Quastions? value) {
                                        setState(() {
                                          _quastions = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('No'),
                                    leading: Radio<Quastions>(
                                      value: Quastions.No,
                                      groupValue: _quastions,
                                      onChanged: (Quastions? value) {
                                        setState(() {
                                          _quastions = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],),
                                const SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFE3C263)),
                                          minimumSize:
                                          MaterialStateProperty.all<Size>(
                                            const Size(200, 60),
                                          ), // Set button width and height
                                        ),
                                        onPressed: () {},
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(width: 8),
                                            Text('Save'),
                                            SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFE3C263)),
                                          minimumSize:
                                          MaterialStateProperty.all<Size>(
                                            const Size(200, 60),
                                          ), // Set button width and height
                                        ),
                                        onPressed: () {
                                        },
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(width: 8),
                                            Text('Submit'),
                                            SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 50.0),
                          ],
                        ),
                      ]),
                    )
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

