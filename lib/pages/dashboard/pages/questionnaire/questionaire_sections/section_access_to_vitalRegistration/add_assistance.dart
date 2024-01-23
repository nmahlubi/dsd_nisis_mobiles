import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../house_hold_questionnaire.dart';


enum Quastions { Yes, No, Maybe }
class AddAssistance extends StatefulWidget {
  const AddAssistance({super.key});

  @override
  State<AddAssistance> createState() => _AddAssistanceState();
}

class _AddAssistanceState extends State<AddAssistance> {

  String? selectedOption;
  bool _showTerms = false;
  bool _showDateSelector = false;
  DateTime? _selectedDate;
  TextEditingController _searchController = TextEditingController();
  TextEditingController _outcomeController = TextEditingController();
  String? _selectedOption;

  final List<String> _firstDropdownOptions = ['Option 1', 'Option 2', 'Option 3'];
  String _selectedFirstOption = 'Option 1';


  final Map<String, List<String>> _secondDropdownOptions = {
    'Option 1': ['Value 1.1', 'Value 1.2', 'Value 1.3'],
    'Option 2': ['Value 2.1', 'Value 2.2', 'Value 2.3'],
    'Option 3': ['Value 3.1', 'Value 3.2', 'Value 3.3'],
  };
  String _selectedSecondOption = 'Value 1.1';
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
                                              Text(
                                                'HomeAffairs Assistance ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InputDecorator(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedFirstOption,
                                          items: _firstDropdownOptions.map((String option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedFirstOption = newValue ?? '';
                                              _selectedSecondOption = _secondDropdownOptions[_selectedFirstOption]![0];
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    const Text('Service request'),
                                    SizedBox(height: 20),
                                    InputDecorator(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: _selectedSecondOption,
                                          items: _secondDropdownOptions[_selectedFirstOption]!.map((String option) {
                                            return DropdownMenuItem<String>(
                                              value: option,
                                              child: Text(option),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedSecondOption = newValue ?? '';
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    const Text('First Time Applicant'),
                                    SizedBox(height: 20),
                                    RadioListTile<String>(
                                      title: Text('Yes'),
                                      value: 'Yes',
                                      groupValue: selectedOption,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedOption = value;
                                          _showTerms = true;
                                          _showDateSelector = false;
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
                                          _showTerms = false;
                                          _showDateSelector = true;
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
                                          _showTerms = false;
                                          _showDateSelector = false;
                                        });
                                      },
                                    ),
                                    Visibility(
                                      visible: _showTerms,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        padding: EdgeInsets.all(16.0),
                                        margin: EdgeInsets.symmetric(vertical: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Terms and Conditions:',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _showDateSelector,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Select Date:',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                            child: AbsorbPointer(
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintText: _selectedDate != null
                                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                                      : 'Select Date',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          TextField(
                                            controller: _outcomeController,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          const Text(
                                            'Search Where You Have Applied Before:',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          TextField(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.0),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            padding: EdgeInsets.all(16.0),
                                            margin: EdgeInsets.symmetric(vertical: 20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Terms and Conditions:',
                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),

                                const SizedBox(height: 10.0),
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
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(width: 8),
                                            Text('back'),
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
                            const SizedBox(height: 50.0),
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

