import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../domain/repository/household/household_details_repository.dart';
import '../../../../model/coordinates/coordinates_dto.dart';
import '../../../../model/household/house_dto.dart';
import '../../../../model/household/household_details_dto.dart';
import '../../../../service/hive_service.dart';
import '../../../../service/house_hold/household_details_service.dart';
import '../../../../widget/camera_picker.dart';
import '../../../../widget/image_enlarger.dart';
import '../../../../widget/image_picker.dart';
import '../../../../widget/image_widget.dart';

import '../worklist_page.dart';
import 'house_hold_details.dart';

class CreateHouseHoldProfile extends StatefulWidget {
  CreateHouseHoldProfile({
    super.key,
  });

  @override
  State<CreateHouseHoldProfile> createState() => _CreateHouseHoldProfileState();
}

class _CreateHouseHoldProfileState extends State<CreateHouseHoldProfile> {
  String? dropdownValue;
  bool isEnlarged = false;
  String displayedCoordinateLat = '';
  String displayedCoordinateLon = '';

  Future<void> getWeatherCoordinates() async {
    late final HouseHoldDto houseHoldDto;
    final apiKey = '0cebbf25b4c56494893333e85f2f9f39';
    final city = 'Johannesburg';

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=imperial&appid=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final double latitude = data['coord']['lat'];
      final double longitude = data['coord']['lon'];

      setState(() {
        displayedCoordinateLat = 'Latitude: ${latitude.toStringAsFixed(4)}';
        displayedCoordinateLon = 'Longitude: ${longitude.toStringAsFixed(4)}';
        _coordinateLatController.text = displayedCoordinateLat;
        _coordinateLonController.text = displayedCoordinateLon;
      });
    } else {
      setState(() {
        displayedCoordinateLat = 'Failed to fetch coordinates';
        displayedCoordinateLon = 'Failed to fetch coordinates';
      });
    }
  }

  late Box<Map<dynamic, dynamic>> box;

  Future<void> openHiveBox() async {
    if (!Hive.isBoxOpen('householddetailsbox')) {
      //householddetailsbox = await Hive.openBox('householddetailsbox');
    } else {
      box = Hive.box('householddetailsbox');
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _focus = FocusNode();
  bool _isValidate = true;

  TextEditingController _dwellingUnitAddressController =
  TextEditingController();
  TextEditingController _dwellingUnitDescriptionController =
  TextEditingController();
  TextEditingController _profileToolId = TextEditingController();
  TextEditingController _dwellingUnitNumber = TextEditingController();
  TextEditingController _householdNumber = TextEditingController();
  TextEditingController _eANumber = TextEditingController();
  TextEditingController _capturedByUserId = TextEditingController();
  TextEditingController profilingDate = TextEditingController();
  TextEditingController _coordinateLatController = TextEditingController();
  TextEditingController _coordinateLonController = TextEditingController();
  TextEditingController _householdQuestionId = TextEditingController();
  TextEditingController _structureType = TextEditingController();

  SharedPreferences? preferences;

  TextEditingController provinceId = TextEditingController();
  TextEditingController coordinatesTextcontroller = TextEditingController();
  TextEditingController eANumber = TextEditingController();
  TextEditingController profileToolId = TextEditingController();
  TextEditingController householdQuestionId = TextEditingController();
  TextEditingController structureType = TextEditingController();
  TextEditingController dwellingUnitAddressController = TextEditingController();
  TextEditingController dwellingUnitDescriptionController =
  TextEditingController();
  TextEditingController _dateInput = TextEditingController();

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  late HouseHoldDto houseHoldDto = HouseHoldDto();
  late HouseHoldDetailsDto houseHoldDetailsDto = HouseHoldDetailsDto();
  final HouseholdDetailsService householdDetailsService =
  HouseholdDetailsService();
  late Weather weather;

  @override
  void initState() {
    super.initState();
    openHiveBox();
    _dateInput.text = "";
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializePreference().whenComplete(() {
        HouseholdDetailsRepository().initialize();
        _coordinateLatController =
            TextEditingController(text: displayedCoordinateLat);
        _coordinateLonController =
            TextEditingController(text: displayedCoordinateLon);
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
  void dispose() {
    //Hive.close();
    //Hive.Box('household').close();
    super.dispose();
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
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WorkListPage()),
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
                      const Column(
                        children: [
                          Center(
                            child: Text(
                              'Household',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                      0xFFE3C263) // Adjusted to provided color
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              'Profiling',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                      0xFFE3C263) // Adjusted to provided color
                              ),
                            ),
                          ),
                          SizedBox(height: 50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create Household Information',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(
                                        0xFF808080) // Adjusted to provided color
                                ),
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 2, color: Colors.grey, endIndent: 10),
                          SizedBox(
                            width: 50,
                          )
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                                      const Size(200, 50),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {
                                    _showCustomDialog(context);
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('Add household image'),
                                      SizedBox(width: 4),
                                      Icon(Icons.add),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Border radius
                                ),
                                child: ImageWidget(),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ImageEnlarger(),
                            const SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.blue),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(200, 50),
                                ), // Set button width and height
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(width: 8),
                                  Text('Delete'),
                                  SizedBox(width: 4),
                                  Icon(Icons.delete),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ]),
                      const SizedBox(height: 30.0),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Date'),
                                buildFormField(
                                  key: Key('provinceIdFormField'),
                                  controller: _dateInput,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                      setState(() {
                                        _dateInput.text = formattedDate;
                                      });
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a valid date';
                                    }
                                    // You can add more specific date validation logic if needed
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10.0),
                                Text('EA Number'),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  hint: const Text(''),
                                  value: dropdownValue,
                                  onChanged: (String? newValue) {
                                    _eANumber =
                                    newValue! as TextEditingController;
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    "131313789",
                                    "08367256",
                                  ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Question ID'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _householdQuestionId,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter question Id',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Profiling Tool'),
                                const SizedBox(height: 5),
                                DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  hint: const Text(''),
                                  value: dropdownValue,
                                  onChanged: (String? newValue) {
                                    _profileToolId =
                                    newValue! as TextEditingController;
                                    setState(() {
                                      _profileToolId =
                                      newValue! as TextEditingController;
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    "War on Poverty Programme",
                                    "Rural"
                                  ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Structure Type'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _structureType,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter structure type',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Dwelling Address'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _dwellingUnitAddressController,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter dwelling Address',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Dwelling Description'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller:
                                  _dwellingUnitDescriptionController,
                                  // TextEditingController for numeric inputs
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter dwelling Description',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Dwelling Unit Number'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _dwellingUnitNumber,
                                  // TextEditingController for numeric inputs
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter dwelling Unit Number',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Text('Household Number'),
                                const SizedBox(height: 5),
                                TextField(
                                  controller: _householdNumber,
                                  // TextEditingController for numeric inputs
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter Household Number',
                                      labelText: ''),
                                ),
                                const SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (coordinatesTextcontroller.text.isEmpty)
                                        ? const Text(
                                      "Dwelling Co-ordinates",
                                      style: TextStyle(),
                                    )
                                        : Text(
                                        'Sent Message: ${coordinatesTextcontroller.text}'),
                                    const SizedBox(
                                      width: 50.0,
                                    ),
                                    const Icon(
                                      Icons.quiz_sharp,
                                      size: 15.0,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Center(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                      minimumSize:
                                      MaterialStateProperty.all<Size>(
                                        const Size(200, 50),
                                      ), // Set button width and height
                                    ),
                                    onPressed: getWeatherCoordinates,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        SizedBox(width: 8),
                                        Text('Generate Co-Ordinates'),
                                        SizedBox(width: 4),
                                        Icon(Icons.downloading),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller: _coordinateLatController,
                                      decoration: const InputDecoration(
                                        hintText: 'Latitude',
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller: _coordinateLonController,
                                      decoration: const InputDecoration(
                                        hintText: 'Longitude',
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(
                                          const Size(200, 50),
                                        ), // Set button width and height
                                      ),
                                      onPressed: () async {
                                        // Retrieve the values from the text controllers
                                        String dateInput = _dateInput.text;
                                        String profileToolId =
                                            _profileToolId.text;
                                        String dwellingUnitNumber =
                                            _dwellingUnitNumber.text;
                                        String householdNumber =
                                            _householdNumber.text;
                                        String eANumber = _eANumber.text;
                                        String capturedByUserId =
                                            _capturedByUserId.text;
                                        String dwellingUnitAddressController =
                                            _dwellingUnitAddressController.text;
                                        String
                                        dwellingUnitDescriptionController =
                                            _dwellingUnitDescriptionController
                                                .text;
                                        String coordinateLatController =
                                            _coordinateLatController.text;
                                        String coordinateLonController =
                                            _coordinateLonController.text;
                                        String householdQuestionId =
                                            _householdQuestionId.text;
                                        String structureType =
                                            _structureType.text;

                                        // Create data to send if validation passes
                                        Map<String, dynamic> createdData = {
                                          "profiling_Instance_Id": 0,
                                          "profiling_Date":
                                          "2023-11-29T10:45:55.565Z",
                                          "dateInput": dateInput,
                                          "profileToolId": profileToolId,
                                          "dwellingUnitNumber":
                                          dwellingUnitNumber,
                                          "householdNumber": householdNumber,
                                          "eANumber": eANumber,
                                          "capturedByUserId": capturedByUserId,
                                          "dwellingUnitAddressController":
                                          dwellingUnitAddressController,
                                          "dwellingUnitDescriptionController":
                                          dwellingUnitDescriptionController,
                                          "coordinateLatController":
                                          coordinateLatController,
                                          "coordinateLonController":
                                          coordinateLonController,
                                          "householdQuestionId":
                                          householdQuestionId,
                                          "structureType": structureType,
                                        };

                                        const String apiUrl =
                                            'https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/Add';
                                        //final box = Hive.box('householddetailsbox');
                                        final response = await http.post(
                                          Uri.parse(apiUrl),
                                          headers: <String, String>{
                                            'Content-Type':
                                            'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(createdData),
                                        );

                                        if (response.statusCode == 200) {
                                          final _dateInput = DateTime.now()
                                              .millisecondsSinceEpoch;
                                          final userKey =
                                              'user_data_$_dateInput.text';

                                          //await box.put(userKey, createdData);
                                          print(
                                              'User data saved to box with key $userKey: $createdData');
                                          Navigator.pop(context, createdData);
                                        } else {
                                          print(
                                              'Failed to add data: ${response.statusCode}');
                                          // Handle API request failure or show an error message
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
                                    const SizedBox(width: 10.0),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(
                                          const Size(200, 50),
                                        ), // Set button width and height
                                      ),
                                      onPressed: () async {
                                        // Retrieve the values from the text controllers
                                        String dateInput = _dateInput.text;
                                        String? profileToolId = dropdownValue;
                                        String dwellingUnitNumber =
                                            _dwellingUnitNumber.text;
                                        String householdNumber =
                                            _householdNumber.text;
                                        String eANumber = _eANumber.text;
                                        String capturedByUserId =
                                            _capturedByUserId.text;
                                        String dwellingUnitAddressController =
                                            _dwellingUnitAddressController.text;
                                        String
                                        dwellingUnitDescriptionController =
                                            _dwellingUnitDescriptionController
                                                .text;
                                        String coordinateLatController =
                                            _coordinateLatController.text;
                                        String coordinateLonController =
                                            _coordinateLonController.text;
                                        String householdQuestionId =
                                            _householdQuestionId.text;
                                        String structureType =
                                            _structureType.text;

                                        // Validation logic for each field
                                        if (dateInput.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Please enter a date')),
                                          );
                                          return;
                                        }
                                        // if (dropdownValue == null || dropdownValue!.isEmpty) {
                                        //   ScaffoldMessenger.of(context).showSnackBar(
                                        //     const SnackBar(
                                        //       content: Text('Please select profile Tool'),
                                        //     ),
                                        //   );
                                        //   return;
                                        // }
                                        // if (dwellingUnitNumber.isEmpty) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     const SnackBar(
                                        //         content: Text(
                                        //             'Please enter a dwelling Unit Number')),
                                        //   );
                                        //   return;
                                        // }
                                        // if (householdNumber.isEmpty) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     const SnackBar(
                                        //         content: Text(
                                        //             'Please the household Number')),
                                        //   );
                                        //   return;
                                        // }
                                        // if (eANumber.isEmpty) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(
                                        //     const SnackBar(
                                        //         content: Text(
                                        //             'Please enter EA Number')),
                                        //   );
                                        //   return;
                                        // }
                                        if (dwellingUnitAddressController
                                            .isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Please enter a dwelling Unit Address')),
                                          );
                                          return;
                                        }
                                        if (householdQuestionId.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Please enter a household QuestionId')),
                                          );
                                          return;
                                        }
                                        if (structureType.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Please enter the structure Type')),
                                          );
                                          return;
                                        }

                                        // Create data to send if validation passes
                                        Map<String, dynamic> createdData = {
                                          "profiling_Instance_Id": 0,
                                          "profiling_Date":
                                          "2023-11-29T10:45:55.565Z",
                                          "dateInput": dateInput,
                                          "profileToolId": profileToolId,
                                          "dwellingUnitNumber":
                                          dwellingUnitNumber,
                                          "householdNumber": householdNumber,
                                          "eANumber": eANumber,
                                          "capturedByUserId": capturedByUserId,
                                          "dwellingUnitAddressController":
                                          dwellingUnitAddressController,
                                          "dwellingUnitDescriptionController":
                                          dwellingUnitDescriptionController,
                                          "coordinateLatController":
                                          coordinateLatController,
                                          "coordinateLonController":
                                          coordinateLonController,
                                          "householdQuestionId":
                                          householdQuestionId,
                                          "structureType": structureType,
                                        };

                                        const String apiUrl =
                                            'https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/Add';
                                        final response = await http.post(
                                          Uri.parse(apiUrl),
                                          headers: <String, String>{
                                            'Content-Type':
                                            'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(createdData),
                                        );

                                        if (response.statusCode == 200) {
                                          // Data added successfully, navigate to the next screen
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HouseholdDetails(
                                                      data: createdData, requestData: {},),
                                            ),
                                          );
                                        } else {
                                          print(
                                              'Failed to add data: ${response.statusCode}');
                                        }
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget buildFormField({
    required TextEditingController controller,
    int? maxLines,
    TextInputType? keyboardType,
    Function()? onTap,
    required Key key,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (controller.text.isEmpty)
            ? Text('')
            : Text('Sent Message: ${controller.text}'),
        TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onTap: onTap,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ';
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
      ],
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPicker()),
                    );
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

