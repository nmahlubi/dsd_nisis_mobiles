import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../domain/db_model_hive/household/household.member.model.dart';
import '../../../../widget/image_enlarger_description.dart';
import '../../../../widget/image_widget.dart';
import '../../../../widget/next_details_screen.dart';
import '../questionnaire/house_hold_questionnaire.dart';
import '../referrals/house_hold_details_referrals.dart';
import 'add_house_member.dart';
import 'house_hold_view_more.dart';
import 'package:http/http.dart' as http;

class HouseholdDetails extends StatefulWidget {
  final Map<String, dynamic> requestData;
  final Map<String, dynamic> data;


  HouseholdDetails(
      {super.key,
        required this.data, required this.requestData,});

  @override
  State<HouseholdDetails> createState() => _HouseholdDetailsState();
}

class _HouseholdDetailsState extends State<HouseholdDetails> {
  TextEditingController _profileToolId = TextEditingController();
  TextEditingController _relationshipController = TextEditingController();
  TextEditingController _maritalStatusController= TextEditingController();
  TextEditingController _egeController= TextEditingController();
  TextEditingController _dateofBirthController = TextEditingController();
  TextEditingController profilingDate = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _birthCountryController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noIDtextController = TextEditingController();
  String _selectedValue = '';

  List<Map<String, dynamic>> siteData = [];
  late Future<MemberData> _memberData;
  Map<String, dynamic>? requestData;



  @override
  void initState() {
    super.initState();
    fetchAndProcessData();
    _memberData = fetchMemberData();
  }

  late Box<Map<dynamic, dynamic>> box;

  Future<void> openHiveBox() async {
    if (!Hive.isBoxOpen('householddetailsbox')) {
      //householddetailsbox = await Hive.openBox('householddetailsbox');
    } else {
      box = Hive.box('householddetailsbox');
    }
  }

  Future<void> fetchAndProcessData() async {
    try {
      final response = await http.get(
          Uri.parse('https://testportal.dsd.gov.za/msnisis/api/Site/userprovinceId/4'));
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> fetchedData =
        List<Map<String, dynamic>>.from(json.decode(response.body));
        setState(() {
          siteData = fetchedData;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<List<Map<String, dynamic>>> memberProcessData() async {
    final response = await http.get(Uri.parse('https://localhost:7254/api/RelativeHouseholdmember/GetAll'));
    if (response.statusCode == 200) {
      List<dynamic> parsedData = jsonDecode(response.body);
      List<Map<String, dynamic>> dataList = [];
      for (var data in parsedData) {
        var siteEaDto = data['siteEaDto'];
        var capturedByUserId = data['capturedByUserId'] ?? 'Unknown';
        var siteEaSegments = siteEaDto['siteEaSegments'] as List<dynamic>;
        var dateCreated = siteEaDto['dateCreated'] ?? 'Unknown';
        var siteEaId = siteEaDto['siteEaId'] ?? 'Unknown';
        var createdBy = data['createdBy'] ?? 'Unknown';
        var date_Created = data['date_Created'] ?? 'Unknown';
        var hhid = data['hhid'] ?? 'Unknown';
        var profilingDate = data['profilingDate'] ?? 'Unknown';

        for (var segment in siteEaSegments) {
          var dwellingUnitAddress =
              segment['dwelling_Unit_Address'] ?? 'Unknown';
          var boundaryDescription =
              segment['boundaryDescription'] ?? 'Unknown';
          var listingStartPointDescription =
              segment['listingStartPointDescription'] ?? 'Unknown';

          for (var data in parsedData) {
            var siteEaDto = data['siteEaDto'];
            var eaCode = siteEaDto['eaCode'] ?? 'Unknown';
            var site = siteEaDto['site'];
            var siteName = site['siteName'] ?? 'Unknown';

            dataList.add({
              'eaCode': eaCode,
              'hhid': hhid,
              'profilingDate': profilingDate,
              'date_Created': date_Created,
              'createdBy': createdBy,
              'capturedByUserId': capturedByUserId,
              'siteName': siteName,
              'dateCreated': dateCreated,
              'siteEaId': siteEaId,
              'dwellingUnitAddress': dwellingUnitAddress,
              'boundaryDescription': boundaryDescription,
              'listingStartPointDescription': listingStartPointDescription,
            });
          }
        }
      }

      return dataList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MemberData> fetchMemberData() async {
    final response = await http.get(Uri.parse('https://testportal.dsd.gov.za/msnisis/api/Householdmember/id/3'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return MemberData.fromJson(responseData);
    } else {
      throw Exception('Failed to load member data');
    }
  }



  @override
  void dispose() {
    _noIDtextController.dispose();
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
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => WorkListPage()),
                              // );
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
                              // Container(
                              //   margin: const EdgeInsets.only(left: 100.0),
                              //   child: Text(
                              //     'Logged in as: ${preferences?.getString('firstname')}',
                              //     style: const TextStyle(
                              //         fontSize: 7.0, color: Colors.black87),
                              //   ),
                              // ),
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
                              'Household Details',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                      0xFFE3C263) // Adjusted to provided color
                              ),
                            ),
                          ),
                          const SizedBox(height: 50.0),
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
                                          'Household Details',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
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
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('HouseHold Question ID'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Profiling Tool 1'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.data['householdQuestionId'] ?? 'Not Available'}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text('${widget.data['profileToolId'] ?? 'Not Available'}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
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
                                borderRadius:
                                BorderRadius.circular(10.0), // Border radius
                              ),
                              child: ImageWidget(),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ImageEnlargerDescription(),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Dwelling Unit Address'),
                              const SizedBox(
                                width: 1,
                              ),
                              Text('${widget.data['dwellingUnitAddressController'] ?? 'Not Available'}'),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.cyan[100]!),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50),
                                  ), // Set button width and height
                                ),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(width: 8),
                                    Text('Completed'),
                                    SizedBox(width: 4),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.cyan[100]!),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(100, 50),
                                  ), // Set button width and height
                                ),
                                onPressed: () {},
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(width: 8),
                                    Text('QA Review'),
                                    SizedBox(width: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
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
                                      Text('View More Info'),
                                      SizedBox(width: 1),
                                      Icon(Icons.expand_more),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: ElevatedButton(
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
                                      Text('Edit House Details'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            child: Center(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: siteData.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> site = siteData[index];
                                      return  ListTile(
                                        subtitle: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${widget.data['dateInput'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${widget.data['profileToolId'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(' ${widget.data['dwellingUnitNumber'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(' ${widget.data['householdNumber'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${site['provinces']['description']}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${site['provinces']['districts'][index]['localMunicipalities'][index]['description']}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${site['provinces']['districts'][index]['description']}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${site['provinces']['districts'][index]['localMunicipalities'][index]['ward']['description']}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${site['siteName']}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${widget.data['eANumber'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${widget.data['capturedByUserId'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${widget.data['coordinateLatController'] ?? 'Not Available'}'),
                                                Text('${widget.data['coordinateLonController'] ?? 'Not Available'}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Add more data to display as needed
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),),
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
                                          'Household Member(s)',
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ),
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
                                    const Size(300, 40),
                                  ), // Set button width and height
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddHouseMember()),
                                  );
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(width: 8),
                                    Text('Add HouseHold Member'),
                                    SizedBox(width: 4),
                                    Icon(Icons.add),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ID Number',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('NO ID Number'),
                                  ],
                                ),
                                Align(
                                  // alignment: Alignment.center,
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    child: const VerticalDivider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 0,
                                      width: 20,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'ID Status',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'verified',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                            minimumSize:
                                            MaterialStateProperty.all<Size>(
                                              const Size(8, 8),
                                            ), // Set button width and height
                                          ),
                                          onPressed: () {},
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(width: 8),
                                              Text('verified'),
                                              SizedBox(width: 4),
                                              Icon(Icons.verified,
                                                  size: 20, color: Colors.green),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // handle button press
                                          },
                                          child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                              child: const Icon(
                                                Icons.question_mark,
                                                color: Colors.white,
                                                size: 10,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.grey,
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
                                    border:
                                    Border.all(width: 2, color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                          const SizedBox(height: 30),

                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FutureBuilder<MemberData>(
                            future: _memberData,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Or any loading indicator widget
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final memberData = snapshot.data;

                                // Check if requestData is available after adding a new member
                                if (requestData != null) {
                                  // Display requestData
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Name'),
                                              SizedBox(height: 10),
                                              Text('Surname'),
                                              SizedBox(height: 10),
                                              Text('Age'),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('Name: ${widget.requestData?['first_Name'] ?? ''}'),
                                              SizedBox(height: 10),
                                              Text('Surname: ${widget.requestData?['last_Name'] ?? ''}'),
                                              SizedBox(height: 10),
                                              Text('Age: ${widget.requestData?['age']?.toString() ?? ''}'),
                                              SizedBox(height: 10),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  // Display memberData
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Name'),
                                              SizedBox(height: 10),
                                              Text('Surname'),
                                              SizedBox(height: 10),
                                              Text('Age'),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text('Name: ${memberData?.firstName ?? ''}'),
                                              SizedBox(height: 10),
                                              Text('Surname: ${memberData?.lastName ?? ''}'),
                                              SizedBox(height: 10),
                                              Text('Age: ${memberData?.age.toString() ?? ''}'),
                                              SizedBox(height: 10),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              }
                            },
                          ),

                          // FutureBuilder<MemberData>(
                          //   future: _memberData,
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState == ConnectionState.waiting) {
                          //       return CircularProgressIndicator(); // Or any loading indicator widget
                          //     } else if (snapshot.hasError) {
                          //       return Text('Error: ${snapshot.error}');
                          //     } else {
                          //       final memberData = snapshot.data!;
                          //       return Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             crossAxisAlignment: CrossAxisAlignment.center,
                          //             children: [
                          //               Column(
                          //                 mainAxisAlignment: MainAxisAlignment.start,
                          //                 crossAxisAlignment: CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text('Name'),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Text('Surname'),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Text('Age'),
                          //                   SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                 ],
                          //               ),
                          //               Column(
                          //                 mainAxisAlignment: MainAxisAlignment.end,
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //                 children: [
                          //                   Text('Name: ${memberData.firstName}'),
                          //                   const SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Text('Surname: ${memberData.lastName}'),
                          //                   const SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                   Text('Age: ${memberData.age.toString()}'),
                          //                   const SizedBox(
                          //                     height: 10,
                          //                   ),
                          //                 ],
                          //               )
                          //             ],
                          //           ),
                          //         ],
                          //       );
                          //     }
                          //   },
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Completed 0/8'),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 200.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(
                                          const Size(100, 40),
                                        ), // Set button width and height
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HouseHoldQuestionnaire()),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(width: 8),
                                          Text('Questionnaire'),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_outlined),
                                        ],
                                      ),
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
                              Text('Completed 0/2'),
                              const SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 200.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                        minimumSize:
                                        MaterialStateProperty.all<Size>(
                                          const Size(100, 40),
                                        ), // Set button width and height
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HouseHolsDetailsReferrals()),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text('Referals'),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_outlined),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(200, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Holdhold_View_More()),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('View More'),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(200, 40),
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
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(150, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                      SizedBox(width: 4),
                                      Icon(Icons.edit),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
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
}
