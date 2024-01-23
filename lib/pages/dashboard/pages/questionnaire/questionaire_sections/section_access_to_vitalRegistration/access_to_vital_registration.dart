import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../house_hold_questionnaire.dart';
import 'add_assistance.dart';

enum Quastions { Yes, No, Maybe }

class AccessToVitalRegistration extends StatefulWidget {
  const AccessToVitalRegistration({super.key});

  @override
  State<AccessToVitalRegistration> createState() =>
      _AccessToVitalRegistrationState();
}

class _AccessToVitalRegistrationState extends State<AccessToVitalRegistration> {
  List<String> selectedItems = [];
  List<String> selected2Items = [];

  void _showChecklist(BuildContext context) async {
    List<String> allOptions = [
      'None/dont know',
      'Political parties/Trade Unions',
      'Environment groups',
      'Parents/School Association',
      'Neighborhood watch',
      'Religious groups/ Church groups'
    ];

    List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Options'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(allOptions[index]),
                    value: selectedItems.contains(allOptions[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          selectedItems.add(allOptions[index]);
                        } else {
                          selectedItems.remove(allOptions[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedItems);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedItems = result;
      });
    }
  }

  void _showChecklist2(BuildContext context) async {
    List<String> allOptions = [
      'None/dont know',
      'Political parties/Trade Unions',
      'Environment groups',
      'Parents/School Association',
      'Neighborhood watch',
      'Religious groups/ Church groups'
    ];

    List<String> result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Options'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(allOptions[index]),
                    value: selected2Items.contains(allOptions[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          selected2Items.add(allOptions[index]);
                        } else {
                          selected2Items.remove(allOptions[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(selectedItems);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedItems = result;
      });
    }
  }

  late final String message;
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');
  static const SingleActivator _showShortcut =
      SingleActivator(LogicalKeyboardKey.keyS, control: true);
  bool _showingMessage = false;

  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  String selected = "";
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
                                  builder: (context) =>
                                      HouseHoldQuestionnaire()),
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
                          backgroundColor: Color(0xFF036FE3),
                          // Adjusted to provided blue color
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
                                      color: const Color(0xFFE3C263),
                                      child: const Column(
                                        children: [
                                          Center(
                                              child: Text(
                                            'Questionnaire',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          )),
                                          Center(
                                              child: Text(
                                            'Section 7:Access to Vital Registration(Home Affairs) ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            const Text(
                                '7.1.....is requiring assistance in obtaining \n the following documents category?.  '),
                            const SizedBox(height: 10.0),
                            const Text(
                                ' \u2022 Identity Document\n \u2022 Birth Certificate\n \u2022 Marriage Certificate\n \u2022 Death Certificate\n \u2022 Passport\n \u2022 Resident Permit'),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                      const Size(300, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddAssistance()),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('Add Assistance',style: TextStyle(color: Colors.white)),
                                      SizedBox(width: 4),
                                      Icon(Icons.add),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      width: double.infinity,
                                      height: 30,
                                      color: const Color(0xFFE3C263),
                                      child: const Center(
                                          child: Text(
                                        'Household Member(s)',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ListTile(
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Date Profiled'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Profiling Tool'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Dwelling Unit Number'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('HouseHold Number'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Province'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Municipality'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Local Municipality'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Ward'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Site'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('EA'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Captured by User'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Co-Ordinates'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('Not Available'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Add more data to display as needed
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(180, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Delete',style: TextStyle(color: Colors.white)),
                                      SizedBox(width: 1),
                                      Icon(Icons.delete,color: Colors.white),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(180, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Edit',style: TextStyle(color: Colors.white)),
                                      SizedBox(width: 1),
                                      Icon(Icons.edit,color: Colors.white,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 30.0),
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

class CustomWidget extends StatelessWidget {
  final VoidCallback onTap;
  final List<String> selectedItems;
  final Function(String) onDelete;

  const CustomWidget({
    required this.onTap,
    required this.selectedItems,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.blueGrey,
            child: Center(
              child: const Text(
                'Tap to select options',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        if (selectedItems.isNotEmpty)
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Selected items:',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Wrap(
                  children: selectedItems
                      .map(
                        (item) => Chip(
                          label: Text(item),
                          onDeleted: () {
                            onDelete(item);
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
