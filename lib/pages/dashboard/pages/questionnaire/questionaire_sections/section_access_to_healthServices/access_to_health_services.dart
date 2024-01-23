import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../house_hold_questionnaire.dart';

class AccessToHealthServices extends StatefulWidget {
  const AccessToHealthServices({super.key});

  @override
  State<AccessToHealthServices> createState() => _AccessToHealthServicesState();
}

class _AccessToHealthServicesState extends State<AccessToHealthServices> {
  bool showTerms1 = false;
  bool showTerms2 = false;
  bool showTerms3 = false;
  bool showTerms4 = false;
  bool showTerms5 = false;
  String? selectedOption;
  SharedPreferences? preferences;
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    'Section 5:Access to Health Services ',
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Name Siyabong'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Surname Mthembu'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Gender Male'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Age 34'),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                const Text('5.1.1 Does....have difficulty in'),
                                const SizedBox(height: 10.0),
                                CheckboxListTile(
                                  title: const Text('Visual/in seeing even if uses glasses',
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: showTerms1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      showTerms1 = value ?? false;
                                    });
                                  },
                                ),
                                showTerms1
                                    ? const SizedBox(
                                  height: 200, // Adjust the height as needed
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        QuestionWidget(
                                          question: '',
                                        ),
                                        QuestionWidget(
                                          question: 'DURATION OF DIFFICULTY \n\n is...condition permanent ',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    : SizedBox(),
                                CheckboxListTile(
                                  title: Text('Show Terms 1'),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  value: showTerms2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      showTerms2 = value ?? false;
                                    });
                                  },
                                ),
                                showTerms2
                                    ? SizedBox(
                                  height: 200, // Adjust the height as needed
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        QuestionWidget(
                                          question: 'Question 1: Do you like Flutter?',
                                        ),
                                        QuestionWidget(
                                          question: 'Question 2: Are you enjoying programming?',
                                        ),
                                        // Add more QuestionWidgets for additional questions
                                      ],
                                    ),
                                  ),
                                )
                                    : SizedBox(),

                                const SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
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
                                          Navigator.of(context).pop();
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

class QuestionWidget extends StatefulWidget {
  final String question;

  const QuestionWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          RadioListTile<String>(
            title: Text('Yes'),
            value: 'Yes',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('No'),
            value: 'No',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text('Some'),
            value: 'Some',
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
          RadioListTile<String>(
            title: Text("I Don't Know"),
            value: "I Don't Know",
            groupValue: selectedOption,
            onChanged: (String? value) {
              setState(() {
                selectedOption = value;
              });
            },
          ),
        ],
      ),
    );
  }
}