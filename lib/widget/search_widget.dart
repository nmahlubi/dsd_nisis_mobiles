import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late Box<Map<dynamic, dynamic>> box;
  List<dynamic> searchData = [];
  TextEditingController _eaNumberSearchController = TextEditingController();
  TextEditingController _questionIdSearchController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  String _searchResult = '';
  bool dataAdded = false;
  bool isLoading = false;
  bool _isFetchingData = false;
  late Future<List<Map<String, dynamic>>> _futureHouseHoldData;

  Future<void> openHiveBox() async {
    if (!Hive.isBoxOpen('householddetailsbox')) {
      box = await Hive.openBox('householddetailsbox');
    } else {
      box = Hive.box('householddetailsbox');
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
  Future<List<Map<String, dynamic>>> fetchAndProcessData() async {
    final response = await http.get(Uri.parse('https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/GetAll'));
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
              'hhid': hhid,
              'profilingDate': profilingDate,
              'date_Created': date_Created,
              'createdBy': createdBy,
              'capturedByUserId': capturedByUserId,
              'siteName': siteName,
              'eaCode': eaCode,
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
  Future<void> saveDataToHive(Map<String, dynamic> createdData) async {
    final dataList = await fetchAndProcessData();

    final box = await Hive.openBox('householddetailsbox');

    for (var i = 0; i < dataList.length; i++) {
      final key = 'data_$i';
      await box.put(key, dataList[i]);
      print('Data saved to box with key $key: ${dataList[i]}');
    }

    final userKey = 'user_data';
    await box.put(userKey, createdData);
    print('User data saved to box with key $userKey: $createdData');
    print('Entire DataList: $dataList');

    await box.close();
  }

  Future<List<Map<String, dynamic>>> displayStoredData() async {
    try {
      final box = await Hive.openBox('householddetailsbox');
      final dataList = await box.values.toList();

      final List<Map<String, dynamic>> formattedList = dataList
          .map((dynamic item) => Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
          .toList();

      print('Data List: $dataList'); // Log the raw data list
      print('Formatted List: $formattedList'); // Log the formatted list

      await box.close();
      return formattedList;
    } catch (error) {
      print('Error in displayStoredData(): $error');
      return []; // Return an empty list or handle the error accordingly
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


  void showCustomSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void initState() {
    super.initState();
    _futureHouseHoldData = fetchAndProcessData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test search'),
      ),
      body: AlertDialog(
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
      )

    );
  }
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