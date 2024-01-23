import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../house_hold_questionnaire.dart';

class SkillsEmploymentAndSmallBusiness extends StatefulWidget {
  const SkillsEmploymentAndSmallBusiness({super.key});

  @override
  State<SkillsEmploymentAndSmallBusiness> createState() => _SkillsEmploymentAndSmallBusinessState();
}

class _SkillsEmploymentAndSmallBusinessState extends State<SkillsEmploymentAndSmallBusiness> {
  SharedPreferences? preferences;
  String? selectedOption;
  String? selectedAgreeOption;
  bool _showTerms = false;
  bool _agreeTerms = false;
  bool _showDateSelector = false;
  String? _selectedEarningsOption;
  String? _selectedSeekEmplOption;
  String? _selectedOptionss;
  String? _selected2Option;
  TextEditingController _textLifeGoalController = TextEditingController();
  List<String> _dropdown2Options = ['Option 1', 'Option 2', 'Option 3'];
  TextEditingController _textEditingController = TextEditingController();
  List<String> _dropdownOptions = ['Option 1', 'Option 2', 'Option 3'];

  TextEditingController _earningController = TextEditingController();
  TextEditingController _outcomeController = TextEditingController();
  String? _selectedOption;
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
                                                    'Section 8:Skills, Employment and Small Business',
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
                                const SizedBox(height: 20.0),
                                const Center(
                                  child: Text('Section 8 applies to Household Member because household Member is 15yrs and above.',
                                    style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  const SizedBox(height: 10.0),
                                  Text('8.1 Is....Employed?'),
                                  const SizedBox(height: 5.0),
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
                                  Visibility(
                                    visible: _showTerms,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '8.2 What is the total earnings?',
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Consent to share the information',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 8),
                                        RadioListTile<String>(
                                          title: Text('Yes'),
                                          value: 'Yes',
                                          groupValue: selectedAgreeOption,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedAgreeOption = value;
                                              _agreeTerms = true;
                                              _showDateSelector = false;
                                            });
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: Text('No'),
                                          value: 'No',
                                          groupValue: selectedAgreeOption,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedAgreeOption = value;
                                              _agreeTerms = false;
                                              _showDateSelector = true;
                                            });
                                          },
                                        ),
                                        Visibility(
                                          visible: _agreeTerms,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                '8.3 Total Earnings given in 8.2 ',
                                              ),
                                              SizedBox(height: 10.0),
                                              TextField(
                                                controller: _earningController,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              RadioListTile<String>(
                                                title: Text('Per Week'),
                                                value: 'Yes',
                                                groupValue: _selectedEarningsOption,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedEarningsOption = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<String>(
                                                title: Text('Per Month'),
                                                value: 'No',
                                                groupValue: _selectedEarningsOption,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedEarningsOption = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<String>(
                                                title: Text("Annually"),
                                                value: "I Don't Know",
                                                groupValue: _selectedEarningsOption,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedEarningsOption = value;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.4 Was Employment',
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                'Employment type',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.5 Would....like to',
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                'Life goal',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.6 Has....given up on seeking Employment.',
                                              ),
                                              SizedBox(height: 10.0),
                                              RadioListTile<String>(
                                                title: Text('Yes'),
                                                value: 'Yes',
                                                groupValue: _selectedSeekEmplOption,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedSeekEmplOption = value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<String>(
                                                title: Text('No'),
                                                value: 'No',
                                                groupValue: _selectedSeekEmplOption,
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    _selectedSeekEmplOption = value;
                                                  });
                                                },
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.7 Why has...given up on seeking employment.',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.8 Does...require assistance with the following labour services?',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.9 Does...require assistance for small business?',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10.0),
                                              const Text(
                                                '8.10 What skills ... has. \n Skills',
                                              ),
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButtonFormField<String>(
                                                    value: _selectedOptionss,
                                                    items: _dropdownOptions.map((String option) {
                                                      return DropdownMenuItem<String>(
                                                        value: option,
                                                        child: Text(option),
                                                      );
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        _selectedOptionss = newValue;
                                                        _textEditingController.text = newValue ?? '';
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 30.0),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: _showDateSelector,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.5 Would....like to',
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          'Life goal',
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField<String>(
                                              value: _selectedOptionss,
                                              items: _dropdownOptions.map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionss = newValue;
                                                  _textEditingController.text = newValue ?? '';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.6 Has....given up on seeking Employment.',
                                        ),
                                        SizedBox(height: 10.0),
                                        RadioListTile<String>(
                                          title: Text('Yes'),
                                          value: 'Yes',
                                          groupValue: _selectedSeekEmplOption,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedSeekEmplOption = value;
                                            });
                                          },
                                        ),
                                        RadioListTile<String>(
                                          title: Text('No'),
                                          value: 'No',
                                          groupValue: _selectedSeekEmplOption,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _selectedSeekEmplOption = value;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.7 Why has...given up on seeking employment.',
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField<String>(
                                              value: _selectedOptionss,
                                              items: _dropdownOptions.map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionss = newValue;
                                                  _textEditingController.text = newValue ?? '';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.8 Does...require assistance with the following labour services?',
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField<String>(
                                              value: _selectedOptionss,
                                              items: _dropdownOptions.map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionss = newValue;
                                                  _textEditingController.text = newValue ?? '';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.9 Does...require assistance for small business?',
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField<String>(
                                              value: _selectedOptionss,
                                              items: _dropdownOptions.map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionss = newValue;
                                                  _textEditingController.text = newValue ?? '';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        const Text(
                                          '8.10 What skills ... has. \n Skills',
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField<String>(
                                              value: _selectedOptionss,
                                              items: _dropdownOptions.map((String option) {
                                                return DropdownMenuItem<String>(
                                                  value: option,
                                                  child: Text(option),
                                                );
                                              }).toList(),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _selectedOptionss = newValue;
                                                  _textEditingController.text = newValue ?? '';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30.0),
                                      ],
                                    ),
                                  ),
                                ],),
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
