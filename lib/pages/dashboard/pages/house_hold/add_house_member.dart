import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import '../../../../domain/db_model_hive/household/household.member.model.dart';
import '../../../../domain/repository/household/household_member_repository.dart';
import 'house_hold_details.dart';

enum Quastions { Yes, No }

class AddHouseMember extends StatefulWidget {
  const AddHouseMember({super.key});

  @override
  State<AddHouseMember> createState() => _AddHouseMemberState();
}

class _AddHouseMemberState extends State<AddHouseMember> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _dateofBirthController = TextEditingController();
  TextEditingController profilingDate = TextEditingController();
  TextEditingController _birthCountryController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _idNumberController = TextEditingController();

  TextEditingController _maritalStatusIdController = TextEditingController();
  TextEditingController _relationshipIdController = TextEditingController();

  String _selectedValue = '';
  String? _selectedMaritalStatus;

  TextEditingController searchController = TextEditingController();
  String _searchResult = '';
  bool isLoading = false;
  late TextEditingController _searchController;
  late List<MemberData> searchData = [];
  Quastions? _quastions = Quastions.No;
  List<MemberData> memberList = [];
  List<MemberData> _memberData = [];

  void addMember(MemberData newMember) {
    _memberData.add(newMember);
  }

  int maritalStatusId = 0; // Initialize with default values
  String maritalStatusDescription = '';

  int relationshipTypeId = 0; // Initialize with default values
  String relationshipDescription = '';

// Getter for genderDto
  Map<String, dynamic> getGenderDto(int genderId, String genderDescription) {
    return {
      "gender_Id": genderId,
      "description": genderDescription,
    };
  }

// Getter for nationalityDto
  Map<String, dynamic> getNationalityDto(
      int nationalityId, String nationalityDescription) {
    return {
      "nationality_Id": nationalityId,
      "description": nationalityDescription,
    };
  }

  Future<List<Map<String, dynamic>>> displayStoredData() async {
    try {
      final dataList = await box.values.toList();

      final List<Map<String, dynamic>> formattedList = dataList
          .map((dynamic item) =>
      Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
          .toList();
      print('Data List: $dataList');
      print('Formatted List: $formattedList');
      await box.close();
      return formattedList;
    } catch (error) {
      print('Error in displayStoredData(): $error');
      return [];
    }
  }

  void showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<List<MemberData>> fetchDataById(String idNumber) async {
    try {
      final response = await http.get(Uri.parse(
          'https://testportal.dsd.gov.za/msnisis/api/Householdmember/Id_Number/$idNumber'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<MemberData> memberList =
        responseData.map((json) => MemberData.fromJson(json)).toList();

        memberList.forEach((member) {
          print('Member ID: ${member.age}');
          print('Member Name: ${member.firstName}');
        });

        return memberList;
      } else {
        throw Exception(
            'Failed to load member data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  late Box<Map<dynamic, dynamic>> box;

  Future<void> openHiveBox() async {
    if (!Hive.isBoxOpen('householdMemberBox')) {
      householdMemberBox = (await Hive.openBox('householdMemberBox')) as String;
    } else {
      box = Hive.box('householdMemberBox');
    }
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    _quastions = Quastions.No;
    _searchController = TextEditingController();
  }

  void showLoader() {
    setState(() {
      isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      isLoading = false;
    });
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(
                                      0xFFE3C263) // Adjusted to provided blue color
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black // Adjusted text color to white
                              ),
                            ),
                            child: const Text('Close'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
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
                          const Center(
                            child: Text(
                              'Add A House Member',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                      0xFFE3C263) // Adjusted to provided color
                              ),
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10.0),
                                const Text('Do you have an ID'),
                                const SizedBox(height: 10.0),
                                ListTile(
                                  title: const Text('Yes'),
                                  leading: Radio<Quastions>(
                                    value: Quastions.Yes,
                                    groupValue: _quastions,
                                    onChanged: (Quastions? value) {
                                      setState(() {
                                        _quastions =
                                            value; // Update the selected value
                                      });
                                      if (value == Quastions.Yes) {
                                        _showSearchDialog(
                                                (List<MemberData> fetchedData) {
                                              setState(() {
                                                searchData = fetchedData;
                                              });
                                              _showForm(searchData);
                                            });
                                      }
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
                                        _quastions =
                                            value; // Update the selected value
                                      });
                                      if (value == Quastions.No) {
                                        _showsForm(); // Call _showsForm function
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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

  void _showSearchDialog(Function(List<MemberData>) onDataFetched) {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Search Household'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Enter ID Number',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      String searchText = searchController.text;
                      if (searchText.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          List<MemberData> searchData =
                          await fetchDataById(searchText);
                          setState(() {
                            isLoading = false;
                            Navigator.of(context).pop();
                            _showForm(
                                searchData);
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          print('Error: $e');
                        }
                      } else {
                        print('Please enter a search query');
                      }
                    },
                    child: Text('Search'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showForm(List<MemberData> searchData) {
    if (searchData.isNotEmpty) {
      MemberData memberToShow = searchData[0];

      showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 300,
                        child: const Center(
                          child: Text(
                            "Member Image",
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 300,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Center(
                            child: Column(
                              children: [
                                Image.network(
                                  'images/girl.jpg',
                                  width: double.infinity,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text('ID'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Name'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Surname'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Birth Country'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('DOB'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Gender'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Age'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Alive'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('DOD'),
                        SizedBox(height: 10,),
                        Text('Marital Status'),
                        SizedBox(height: 10,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 10,),
                        Text('${memberToShow.identificationNumber ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.firstName ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.lastName ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.nationalityDto ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.dateOfBirth ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.genderDto ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.age ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.dateOfBirth ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.knownAs ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        Text('${memberToShow.maritalstatusDto ?? 'Not Available'}'),
                        const SizedBox(height: 10,),
                        const Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Relationship'),
                            const SizedBox(width: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  height: 50.0,
                                  width: 250.0,
                                  child: DropdownButtonFormField(
                                    value: _relationshipIdController.text.isNotEmpty
                                        ? int.tryParse(_relationshipIdController.text)
                                        : null,
                                    icon: Icon(Icons.keyboard_arrow_down_sharp),
                                    onChanged: (v) {
                                      setState(() {
                                        _relationshipIdController.text = v.toString();
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.teal, width: 1.5),
                                      ),
                                      labelText: "Relationship",
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        child: Text("single"),
                                        value: 1, // Change the value to an integer
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Taken"),
                                        value: 2, // Change the value to an integer
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      );
    } else {
      print('No member data available');
    }
  }

  void _showsForm() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: 150,
                      width: 300,
                      child: const Center(
                        child: Text(
                          "Member Image",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      width: 300,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                          child: Column(
                            children: [
                              Image.network(
                                'images/download.png',
                                width: double.infinity,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
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
                      MaterialStateProperty.all<Color>(Colors.blue),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(200, 40),
                      ), // Set button width and height
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: 8),
                        Text('upload/take image'),
                        SizedBox(width: 4),
                        Icon(Icons.camera_alt),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text('ID'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _idNumberController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Name'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _firstNameController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Surname'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _lastNameController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Birth Country'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _birthCountryController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('DOB'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _dateofBirthController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('AGE'), // Text widget on top
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer
                  Expanded(
                    child: Container(
                      height: 50.0,
                      width: 250.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text',
                          labelText: '',
                        ),
                        controller: _ageController,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Alive'),
                  const SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Yes'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('DOD'),
                  const SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('N/A'),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Marital Status'),
                  const SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 250.0,
                        child: DropdownButtonFormField(
                          value: _maritalStatusIdController.text.isNotEmpty
                              ? _maritalStatusIdController.text
                              : null,
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          onChanged: (v) {
                            setState(() {
                              _maritalStatusIdController.text = v.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 1.5),
                            ),
                            labelText: "Marital Status",
                          ),
                          items: const [
                            DropdownMenuItem(
                              child: Text("Single"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Married"),
                              value: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Relationship'),
                  const SizedBox(width: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: 250.0,
                        child: DropdownButtonFormField(
                          value: _relationshipIdController.text.isNotEmpty
                              ? int.tryParse(_relationshipIdController.text)
                              : null,
                          icon: Icon(Icons.keyboard_arrow_down_sharp),
                          onChanged: (v) {
                            setState(() {
                              _relationshipIdController.text = v.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.teal, width: 1.5),
                            ),
                            labelText: "Relationship",
                          ),
                          items: const [
                            DropdownMenuItem(
                              child: Text("single"),
                              value: 1, // Change the value to an integer
                            ),
                            DropdownMenuItem(
                              child: Text("Taken"),
                              value: 2, // Change the value to an integer
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                      minimumSize: MaterialStateProperty.all<Size>(
                        const Size(300, 80),
                      ),
                    ),
                    onPressed: () async {
                      // Retrieve values from text controllers
                      String firstName = _firstNameController.text;
                      String lastName = _lastNameController.text;
                      String idNumber = _idNumberController.text;
                      String birthCountry = _birthCountryController.text;
                      // String dateOfBirth = _dateofBirthController.text;
                      String age = _ageController.text;

                      //the dummy data for add a member for the required fields
                      String Known_As = '';
                      String Created_By = '';
                      String Modified_By = '';
                      String Phone_Number = '';
                      String Email_Address = '';
                      String Mobile_Phone_Number = '';
                      String Piva_Transaction_Id = '';
                      bool is_Active = false;
                      bool is_Deleted = false;


                      String inputDate = _dateofBirthController.text;
                      String maritalStatusId = _maritalStatusIdController.text;
                      String relationshipTypeId = _relationshipIdController.text;

                      // Create objects for marital status and relationship
                      Map<String, dynamic> maritalstatusDto = {
                        "marital_Status_Id": maritalStatusId,
                        "description": maritalStatusDescription,
                      };

                      Map<String, dynamic> relativeHouseholdmemberDto = {
                        "relationship_Type_Id": relationshipTypeId,
                        "description": relationshipDescription,
                        "source": "string",
                        "definition": "string"
                      };

                      // Create data to send in the request
                      Map<String, dynamic> requestData = {
                        "first_Name": firstName,
                        "last_Name": lastName,
                        "identification_Number": idNumber,
                        "birth_Country": birthCountry,
                        "date_Of_Birth": inputDate,
                        "age": age,
                        "maritalstatusDto": maritalstatusDto,
                        "relativeHouseholdmemberDto": relativeHouseholdmemberDto,
                        //"householdmemberDto": householdmemberDto,
                        //"genderDto": genderDto,
                        // "nationalityDto": nationalityDto,

                        //for the required Data
                        "known_As": Known_As,
                        "created_By": Created_By,
                        "Modified_By": Modified_By,
                        "Phone_Number": Phone_Number,
                        "Email_Address": Email_Address,
                        "Mobile_Phone_Number": Mobile_Phone_Number,
                        "Piva_Transaction_Id": Piva_Transaction_Id,
                        "is_Active": is_Active,
                        "is_Deleted": is_Deleted,

                      };
                      print('Request Data: $requestData');

                      try {
                        final response = await http.post(Uri.parse('https://testportal.dsd.gov.za/msnisis/api/Householdmember/Add'),
                          headers: {
                            'Content-Type': 'application/json',
                            'accept': '*/*',
                          },
                          body: jsonEncode(requestData),
                        );

                        if (response.statusCode == 200) {
                          print('Data added successfully');
                          // MemberData newMember = MemberData(
                          //   // required data from the database
                          //
                          //   citizenshipId:  requestData['citizenshipId'],
                          //   dateCreated:  requestData['dateCreated'],
                          //   dateLastModified:  requestData['dateLastModified'],
                          //   disabilityTypeId:  requestData['disabilityTypeId'],
                          //   genderDto:  requestData['genderDto'],
                          //   sexualOrientationId:  requestData['sexualOrientationId'],
                          //   genderId:  requestData['genderId'],
                          //   identificationTypeId:  requestData['identificationTypeId'],
                          //   maritalStatusId:  requestData['maritalStatusId'],
                          //   preferredContactTypeId:  requestData['preferredContactTypeId'],
                          //   religionId:  requestData['religionId'],
                          //   populationGroupId:  requestData['populationGroupId'],
                          //   personId:  requestData['personId'],
                          //   nationalityId:  requestData['nationalityId'],
                          //   isEstimatedAge:  requestData['isEstimatedAge'],
                          //   isPivaValidated:  requestData['isPivaValidated'],
                          //   nationalityDto:  requestData['nationalityDto'],
                          //   isActive:  requestData['isActive'],
                          //   languageId:  requestData['languageId'],
                          //   isDeleted:  requestData['isDeleted'],
                          //
                          //
                          //   firstName: requestData['first_Name'],
                          //   lastName: requestData['last_Name'],
                          //   identificationNumber: requestData['identification_Number'],
                          //   dateOfBirth: requestData['date_Of_Birth'],
                          //   age: int.parse(requestData['age']),
                          //   maritalstatusDto: requestData['maritalstatusDto'],
                          //   relativeHouseholdmemberDto: requestData['relativeHouseholdmemberDto'],
                          //   knownAs: requestData['known_As'],
                          //   createdBy: requestData['created_By'],
                          //   modifiedBy: requestData['Modified_By'],
                          //   phoneNumber: requestData['Phone_Number'],
                          //   emailAddress: requestData['Email_Address'],
                          //   mobilePhoneNumber: requestData['Mobile_Phone_Number'],
                          //   pivaTransactionId: requestData['Piva_Transaction_Id'],
                          // );
                          // addMember(newMember);
                          // Navigator.pop(context, requestData);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HouseholdDetails(data: {}, requestData: {},)),
                          );
                        } else if (response.statusCode == 400) {
                          setState(() {
                            requestData = requestData;
                          });
                          print('Bad request: ${response.statusCode}');
                          print('Response body: ${response.body}');
                        } else {
                          print('Failed to add data: ${response.statusCode}');
                        }
                      } catch (e) {
                        print('Error adding data: $e');
                      }
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: 8),
                        Text('Save'),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
