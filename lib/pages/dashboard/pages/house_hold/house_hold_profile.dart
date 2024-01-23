import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../domain/repository/household/household_details_repository.dart';
import '../../../../model/household/house_dto.dart';
import '../../../../widget/search_widget.dart';
import 'create_house_hold_profile.dart';
import 'house_hold_details.dart';




class House_ProfilePage extends StatefulWidget {
  const House_ProfilePage({Key? key}) : super(key: key);

  @override
  State<House_ProfilePage> createState() => _House_ProfilePageState();
}

class _House_ProfilePageState extends State<House_ProfilePage> {
  TextEditingController _eaNumberSearchController = TextEditingController();
  TextEditingController _questionIdSearchController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();


  String _searchResult = '';
  bool dataAdded = false;
  bool isLoading = false;
  final HouseholdDetailsRepository repository = HouseholdDetailsRepository();

  late final HouseHoldDto houseHoldDto;
  bool isExpanded = false;
  late String headerName = 'Profiled Houses';
  String housesInProgress = 'Profiled Houses';
  String completedHouses = 'Completed Profiled Houses';

  late Box<Map<dynamic, dynamic>> box;


  void updatehousesInProgress(String newData) {
    setState(() {
      headerName = 'Profiled Houses';
      housesInProgress = newData;
    });
  }

  void updatecompletedHouses(String newData) {
    setState(() {
      headerName = 'Completed Profiled Houses';
      completedHouses = newData;
    });
  }
  SharedPreferences? preferences;

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }
  late Future<List<Map<String, dynamic>>> _futureHouseHoldData;

  List<bool> _isExpandedList = [];
  bool _isValidate = true;

  Future<void> openHiveBox() async {
    if (!Hive.isBoxOpen('householddetailsbox')) {
      box = await Hive.openBox('householddetailsbox');
    } else {
      box = Hive.box('householddetailsbox');
    }
  }
  Future<List<Map<String, dynamic>>> fetchAndProcessData() async {
    final response = await http.get(Uri.parse('https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/GetAll'));
    if (response.statusCode == 200) {
      List<dynamic> parsedData = jsonDecode(response.body);
      List<Map<String, dynamic>> dataList = [];
      _isExpandedList.clear();
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
              _isExpandedList.add(false);
          }
        }
      }

      return dataList;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> saveDataToHive(Map<String, dynamic> createdData) async {
    final dataList = await fetchAndProcessData();

    final box = await Hive.openBox('householddetailsbox');

    for (var i = 0; i < dataList.length; i++) {
      final key = 'data_$i';
      await box.put(key, dataList[i]);
      print('Data saved to box with key $key: ${dataList[i]}');
      print('${box}');
    }

    final userKey = 'user_data';
    await box.put(userKey, createdData);
    print('User data saved to box with key $userKey: $createdData');
    print('Entire DataList: $dataList');

    await box.close();
  }
  Future<List<Map<String, dynamic>>> displayStoredData() async {
    try {
      final dataList = await box.values.toList();

      final List<Map<String, dynamic>> formattedList = dataList
          .map((dynamic item) => Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
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
  Future<void> _performSearch(BuildContext context) async {
    try {
      showLoader();

      final localData = await displayStoredData();

      final String eaNumber = _eaNumberSearchController.text;
      final String questionId = _questionIdSearchController.text;
      TextEditingController _startDateController = TextEditingController();
      TextEditingController _endDateController = TextEditingController();

       final String baseUrl = 'https://localhost:7254/api/HouseholdProfiling/QuestionId/EA_Number';
      final String apiUrl = '$baseUrl/$questionId/$eaNumber';

       final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final apiData = json.decode(response.body) as List<dynamic>;
        List<Map<String, dynamic>> apiDataFormatted = apiData
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList();

        List<Map<String, dynamic>> combinedData = [];
        combinedData.addAll(localData);
        combinedData.addAll(apiDataFormatted);

        if (combinedData.isNotEmpty) {
          showCustomSnackbar(context, 'Item Found!');

          List<Map<String, dynamic>> filteredData = combinedData
              .where((data) =>
          data['hhid'] == questionId &&
              data['siteEaDto']['eaCode'] == eaNumber)
              .toList();

          if (filteredData.isNotEmpty) {
            setState(() {
              _futureHouseHoldData = Future.value(filteredData);
              dataAdded = true;
            });
            print('Filtered Data:');
            print(filteredData);
          } else {
            showCustomSnackbar(context, 'No items found for the given search criteria.');
          }
        }
      } else {
        setState(() {
          _searchResult = 'Request failed with status: ${response.statusCode}';
        });
      }

      await box.close();
    } catch (error) {
      setState(() {
        _searchResult = 'Error occurred: $error';
      });
      print('Error occurred: $error');
    } finally {
      hideLoader();
    }
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

  void showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }



  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
    openHiveBox();
    _futureHouseHoldData = fetchAndProcessData();
  }
  @override
  void dispose() {
    box.close(); // Close the box when the widget is disposed
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
            backgroundColor: Color(0xFFE3C263),
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
                          SizedBox(height: 50.0),
                          const Text(
                            'Household Profiling',
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color:
                                Color(0xFFE3C263) // Adjusted to provided color
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          Center(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(140, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {
                                    headerName = 'Profiled Houses';
                                    updatehousesInProgress('New Data 1');
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('   Profiled Houses  '),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(140, 40),
                                    ), // Set button width and height
                                  ),
                                  onPressed: () {
                                    headerName = 'Completed Profiled Houses';
                                    updatecompletedHouses('');
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text('Completed Houses'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () async {
                              final createdData = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateHouseHoldProfile()),
                              );

                              if (createdData != null) {
                                setState(() {
                                  _futureHouseHoldData = fetchAndProcessData(); // Update the data source
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80.0, vertical: 20.0),
                              primary: const Color(0xFF036FE3),
                              // Adjusted to provided blue color
                              textStyle: TextStyle(color: Colors.white),
                            ),
                            child:  Text('Create Household Profile'),
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 70, height: 1, color: Colors.black87),
                              const Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('OR',
                                    style: TextStyle(color: Colors.black87)),
                              ),
                              Container(
                                  width: 70, height: 1, color: Colors.black87),
                            ],
                          ),
                          SizedBox(height: 30.0),
                          ElevatedButton(
                            onPressed: () {
                              _showSearchDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 80.0, vertical: 20.0),
                              primary: const Color(0xFF036FE3),
                              textStyle: TextStyle(color: Colors.white),
                            ),
                            child: Text('    Search Household      '),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(headerName),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: FutureBuilder<List<dynamic>>(
                      future: Future.wait([_futureHouseHoldData, displayStoredData()]),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshots.hasError) {
                          return Center(child: Text('Error: ${snapshots.error}'));
                        } else {
                          List<Map<String, dynamic>> combinedData = [];
                          if (snapshots.hasData) {
                            if (snapshots.data![0] != null) {
                              combinedData.addAll((snapshots.data![0] as List<dynamic>).cast<Map<String, dynamic>>());
                            }
                            if (snapshots.data![1] != null) {
                              combinedData.addAll((snapshots.data![1] as List<dynamic>).cast<Map<String, dynamic>>());
                            }
                          }

                          if (combinedData.isEmpty) {
                            return Center(child: Text('No data available'));
                          } else {
                            return ListView.builder(
                              itemCount: combinedData.length >= 3 ? 3 : combinedData.length,
                              itemBuilder: (context, index) {
                                var item = combinedData[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Column(
                                        children: [
                                          const Divider(
                                            thickness: 2.0,
                                            height: 40.0,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Date Profiled',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text('${item['date_Created']}'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'QuestionID',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text('${item['hhid']}'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Referral Completed',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text('1/2'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      subtitle: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.blue),
                                                minimumSize: MaterialStateProperty.all<Size>(
                                                  const Size(70, 40),
                                                ), // Set button width and height
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _isExpandedList[index] = !_isExpandedList[
                                                  index]; // Toggle expansion
                                                });
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(width: 8),
                                                  Text(
                                                    _isExpandedList[index]
                                                        ? 'View Less'
                                                        : 'View More',
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(Icons.arrow_drop_down),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.blue),
                                                minimumSize: MaterialStateProperty.all<Size>(
                                                  const Size(70, 40),
                                                ), // Set button width and height
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => HouseholdDetails(data: {}, requestData: {},)),
                                                );
                                              },
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(width: 8),
                                                  Text('Household details'),
                                                  SizedBox(width: 4),
                                                  Icon(Icons.arrow_forward_outlined),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Add the expansion content if _isExpandedList[index] is true
                                    if (_isExpandedList[index]) ...[
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Site Name',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'EA Number',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Address',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Description',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
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
                                                Text('${item['siteName']}',style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${item['eaCode']}',style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${item['listingStartPointDescription']}',style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text('${item['boundaryDescription']}',style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                    )
                      ,)
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
  void _showSearchDialog() {
    bool isLoading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Search Household'),
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 500,
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 5),
                        const Text('EA Number'),
                        TextField(
                          controller: _eaNumberSearchController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter question Id',
                              labelText: ''),
                        ),
                        const SizedBox(height: 10),
                        const Text('QuestionID'),
                        TextField(
                          controller: _questionIdSearchController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter question Id',
                              labelText: ''),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('Start Date'),
                          SizedBox(
                            width: 200,
                            child: buildFormField(
                              key: Key('provinceIdFormField'),
                              controller: _startDateController,
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
                                    _startDateController.text = formattedDate;
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
                          ),
                        ],),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('End Date'),
                            SizedBox(
                              width: 200.0,
                              child:    buildFormField(
                                key: Key('provinceIdFormField'),
                                controller: _endDateController,
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
                                      _endDateController.text = formattedDate;
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                isLoading
                    ? CircularProgressIndicator() // Show loader if isLoading is true
                    : ElevatedButton(
                  onPressed: () async {
                    // Set isLoading to true to show loader
                    setState(() {
                      isLoading = true;
                    });
                    await _performSearch(context);
                    setState(() {
                      isLoading = false;
                    });

                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Search'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

