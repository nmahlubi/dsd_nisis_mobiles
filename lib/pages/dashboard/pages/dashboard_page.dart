import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'worklist_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../../shared/date_input_formatter.dart';
import '../../../service/intake/search_sites.dart';

String siteToJson(Site site) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['siteId'] = site.siteId;
  data['wardId'] = site.wardId;
  data['siteName'] = site.siteName;
  data['siteAlternativeName'] = site.siteAlternativeName;
  data['isActive'] = site.isActive;
  data['dateCreated'] = site.dateCreated;
  data['province'] = site.province;
  data['district'] = site.district;
  data['localMunicipality'] = site.localMunicipality;
  data['ward'] = site.ward;
  data['createdBy'] = site.createdBy;
  data['responsible'] = site.responsible;
  // ... include all other fields
  return json.encode(data);
}

// Data model to represent the API response
class Site {
  final int siteId;
  final int wardId;
  final String siteName;
  final String? siteAlternativeName;
  final bool isActive;
  final String dateCreated;
  final String province;
  final String district;
  final String localMunicipality;
  final String ward;
  final String createdBy;
  final String responsible;
  // ... Include all other fields from the API response

  Site({
    required this.siteId,
    required this.wardId,
    required this.siteName,
    this.siteAlternativeName,
    required this.isActive,
    required this.dateCreated,
    required this.province,
    required this.district,
    required this.localMunicipality,
    required this.ward,
    required this.createdBy,
    required this.responsible,
    // ... Initialize all other fields
  });

  // A method to create a Site object from a map
  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteId: json['siteId'] as int? ?? 0, // Default to 0 if null
      wardId: json['wardId'] as int? ?? 0, // Default to 0 if null
      siteName: json['siteName'] as String? ?? 'Unknown Site Name',
      siteAlternativeName: json['siteAlternativeName'] as String?,
      isActive: json['isActive'] as bool? ?? false, // Default to false if null
      dateCreated: json['createdDate'] as String? ?? 'Unknown Date',
      province: json['province_Id']?.toString() ?? 'Unknown Province',
      district: json['ward']?['localMunicipality']?['district']?['description']
              as String? ??
          'Unknown District',
      createdBy: json['createdBy'] as String? ?? 'Unknown Creator',
      responsible:
          json['responsibleProgrammeId']?.toString() ?? 'Unknown Responsible',
      localMunicipality: json['ward']?['localMunicipalityId']?.toString() ??
          'Unknown Municipality',
      ward: json['ward']?['description'] as String? ?? 'Unknown Ward',
      // ... Handle other fields similarly
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  SharedPreferences? preferences;
  List<Site> sites = [];
  late List<bool> isExpanded; // Declare isExpanded as late
  bool isLoading = false; // Declare the loading indicator variable

  // search site
  final TextEditingController _siteNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String selectedMunicipality = '';
  String selectedLocalMunicipality = '';
  String selectedWard = '';

  final ProvinceService provinceService = ProvinceService();
  List<dynamic> dataSearch = [];
  List<dynamic> districts = [];
  List<dynamic> localMunicipalitiesD = [];
  List<dynamic> wardsSearch = [];
  String? selecteMunicipality;
  String? selecteLocalMunicipality;
  String? selecteWardNumber;
  //ends
  @override
  void dispose() {
    _siteNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void searchSite() async {
    final siteService = SiteService();
    try {
      final response = await siteService.searchSite(
        municipality: selectedMunicipality ?? '',
        localMunicipality: selectedLocalMunicipality ?? '',
        ward: selectedWard ?? '',
        siteName: _siteNameController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Success: ${response.body}');
      } else {
        // Handle non-200 responses
        print('Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error: $e');
    }
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> fetchSites() async {
    final String username = preferences?.getString('username') ?? 'cswarts';
    final String apiUrl =
        'https://testportal.dsd.gov.za/msnisis/api/Site/username/$username';
    final String sitesKey = 'sites_data';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        await preferences?.setString(
            sitesKey, response.body); // Save the response to SharedPreferences
        List<dynamic> siteList = json.decode(response.body);
        setState(() {
          isLoading = false; // Set isLoading to false once data is fetched
          sites = siteList.map((data) => Site.fromJson(data)).toList();
          isExpanded = List.generate(sites.length, (index) => false);
        });
      } else {
        // Handle the case when the server responds with an error
        showDialogMessage('Failed to load sites');
      }
    } catch (e) {
      // Handle any exceptions here
      var storedData = preferences?.getString(sitesKey);
      if (storedData != null) {
        List<dynamic> siteList = json.decode(storedData);
        setState(() {
          isLoading = false;
          sites = siteList.map((data) => Site.fromJson(data)).toList();
          isExpanded = List.generate(sites.length, (index) => false);
        });
      } else {
        // If there's an exception and no data is stored
        showDialogMessage('No data found');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializePreference();
      await fetchSites(); // Fetch the sites data when the widget is initialized
      await fetchSearchData();
    });
  }

  // the init data for seach widget

  Future<void> fetchSearchData() async {
    try {
      dataSearch = await provinceService.fetchSites();
      districts = provinceService.extractDistricts(dataSearch);
      setState(() {});
    } catch (e) {
      print('Error fetching sites: $e');
    }
  }

  void updateLocalMunicipalities(String municipality) {
    print('Selected Municipality: $municipality');
    var extractedLocalMunicipalities =
        provinceService.extractLocalMunicipalities(districts, municipality);
    print('Extracted Local Municipalities: $extractedLocalMunicipalities');

    var descriptions =
        provinceService.extractLocalMunicipalities(districts, municipality);

    setState(() {
      selecteMunicipality = municipality;
      localMunicipalitiesD = descriptions;
      //localMunicipalitiesD = ['Mogale City', 'Merafong City'];
      selecteLocalMunicipality = null;
    });
  }

void updateWards(String localMunicipality) {
  var wards = provinceService.extractWards(localMunicipalitiesD, localMunicipality);
  setState(() {
    selecteLocalMunicipality = localMunicipality;
    wardsSearch = wards; // Directly assign the result as it's already a list of String
    selecteWardNumber = null; // Reset selected ward number
  });
}



  // ends here

  void showDialogMessage(String message) {
    final messageDialog = ScaffoldMessenger.of(context);
    messageDialog.showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .end, // Aligns items to the end of the row
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 100.0),
                                child: Text(
                                  'Logged in as: ${preferences?.getString('firstname')}',
                                  style: TextStyle(fontSize: 7.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 100.0),
                                child: Text(
                                  'Role: CDP',
                                  style: TextStyle(fontSize: 7.0),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 100.0),
                                child: Text(
                                  'Date:08/08/2023 11:43AM',
                                  style: TextStyle(fontSize: 7.0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              width:
                                  10.0), // This will provide some space between the texts and the avatar
                          CircleAvatar(
                            radius: 15.0, // Reduced from the default 20.0
                            backgroundColor: Colors.purple,
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
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "Site Listing",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xFFE3C263),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize:
                          MainAxisSize.max, // Occupy full width of the screen
                      children: [
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xFF036FE3), // Replace with the start color of the gradient if applicable
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation:
                                    4.0, // Adjust the elevation for shadow if needed
                              ),
                              onPressed: () {
                                _showSearchSitePopup(context);
                                fetchSearchData();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Search Site",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.bold, // Make the text bold
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Icon(Icons.search,
                                      color: Colors.white,
                                      size: 24), // Adjust size if needed
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(
                                    0xFF036FE3), // Replace with the start color of the gradient if applicable
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation:
                                    4.0, // Adjust the elevation for shadow if needed
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkListPage()),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "WorkList",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.bold, // Make the text bold
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Icon(Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 24), // Adjust size if needed
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loader when isLoading is true
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Created Sites",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(thickness: 2),
                          SizedBox(height: 20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: sites.length,
                            itemBuilder: (context, index) {
                              final site = sites[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Site Name"),
                                      Text(site.siteName),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Alternative Name"),
                                      Text(site.siteAlternativeName ?? 'N/A'),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Site status"),
                                      Chip(
                                        label: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.0, vertical: 0.2),
                                          child: Text(site.isActive
                                              ? "Active"
                                              : "Inactive"),
                                        ),
                                        backgroundColor: site.isActive
                                            ? Color.fromRGBO(57, 61, 66, 0.7)
                                            : Color.fromRGBO(57, 61, 66, 0.7),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: isExpanded[index],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Date Created"),
                                            Text(site.dateCreated),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Province"),
                                            Text(site.province),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("District Municipality"),
                                            Text(site.district),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Local Municipality"),
                                            Text(site.district),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Ward"),
                                            Text(site.ward),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Created By"),
                                            Text(site.createdBy),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Responsible Program"),
                                            Text(site.responsible),
                                          ],
                                        ),
                                        // ... include other widgets here ...
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isExpanded[index] =
                                                !isExpanded[index];
                                          });
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              isExpanded[index]
                                                  ? "View Less"
                                                  : "View More",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold, // Bold text
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Reduced space between text and icon
                                            Icon(
                                              isExpanded[index]
                                                  ? Icons.arrow_upward
                                                  : Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF036FE3),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10), // Adjust padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded corners
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final site = sites[index];
                                          final siteJsonString =
                                              siteToJson(site);
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          final String worklistKey =
                                              'worklist_sites'; // A key for SharedPreferences
                                          List<String> worklist = prefs
                                                  .getStringList(worklistKey) ??
                                              [];
                                          worklist.add(
                                              siteJsonString); // Add the site JSON string to the worklist
                                          await prefs.setStringList(worklistKey,
                                              worklist); // Save the updated worklist
                                          _showPopup(
                                              context); // Show the confirmation popup
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Add to Worklist",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight
                                                    .bold, // Bold text
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    4), // Reduced space between text and icon
                                            Icon(Icons.add,
                                                color: Colors.white),
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF036FE3),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10), // Adjust padding
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded corners
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 40),
                                  Divider(thickness: 2),
                                ],
                              );
                            },
                          ),

                          // ... Other widgets you may want to include
                        ],
                      ),
                    ),
              Container(
                padding: const EdgeInsets.all(10),
              ),
              if (preferences?.getBool('supervisor') == false)
                _buildTile(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, '/sync-manual-offline'),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Sync(Offline)',
                                style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        Material(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(24.0),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.sync,
                                  color: Colors.white, size: 30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 10),
                Text(
                  'Site added to your Worklist successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
            ),
          ],
        );
      },
    );
  }

  void _showSearchSitePopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          true, // The user must tap a button to dismiss the dialog.
      builder: (BuildContext context) {
        final TextEditingController _siteNameController =
            TextEditingController();
        final TextEditingController _startDateController =
            TextEditingController();
        final TextEditingController _endDateController =
            TextEditingController();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Search Site',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Display user records only',
                        style: TextStyle(fontSize: 16),
                      ),
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {
                          // Handle checkbox change
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Municipality',
                      hintText: 'Please select',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                    value: selecteMunicipality,
                    items: districts
                        .map((district) => district['description'])
                        .toSet() // Convert to Set to remove duplicates
                        .map((description) {
                      return DropdownMenuItem<String>(
                        value: description,
                        child: Text(description),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      updateLocalMunicipalities(newValue!);
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Local Municipality',
                      hintText: 'Please select',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                    value: selecteLocalMunicipality,
                    items: localMunicipalitiesD.isNotEmpty
                        ? localMunicipalitiesD.map((localMunicipality) {
                            return DropdownMenuItem<String>(
                              value: localMunicipality as String,
                              child: Text(localMunicipality as String),
                            );
                          }).toList()
                        : [], // Empty list when there are no local municipalities
                    onChanged: localMunicipalitiesD.isNotEmpty
                        ? (String? newValue) {
                            setState(() {
                              selecteLocalMunicipality = newValue;
                            });
                            updateWards(
                                newValue!); // Call the method to update wards
                          }
                        : null, // Disable onChanged when there are no items
                  ),

                SizedBox(height: 20),
//       DropdownButtonFormField<String>(
//   decoration: InputDecoration(
//     labelText: 'Ward',
//     hintText: 'Please select',
//     floatingLabelBehavior: FloatingLabelBehavior.always,
//     border: OutlineInputBorder(),
//   ),
//   value: selecteWardNumber,
//   items: wardsSearch.map((wardNumber) {
//     return DropdownMenuItem<String>(
//       value: wardNumber, // wardNumber is already a String
//       child: Text('Ward $wardNumber'),
//     );
//   }).toList(),
//   onChanged: (String? newValue) {
//     setState(() {
//       selecteWardNumber = newValue;
//     });
//   },
//   validator: (value) {
//     if (value == null || value.isEmpty) {
//       return 'Please select a ward';
//     }
//     return null;
//   },
// ),


                  // SizedBox(height: 20),
                  DropdownButtonFormField<String?>(
                    decoration: InputDecoration(
                      labelText: 'Ward',
                      border: OutlineInputBorder(),
                    ),
                    items: <String>['7', '4', '20'].map((String value) {
                      return DropdownMenuItem<String?>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // Handle municipality change
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _siteNameController,
                    decoration: InputDecoration(
                      labelText: 'Site Name',
                      hintText: 'Example', // Placeholder text
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Start Date Field with Date Label on top
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child:
                                Text('Start', style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          80.0), // Right padding for 'Date' label
                                  child: Text('Date',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  width: 200, // Width of the TextFormField
                                  child: TextFormField(
                                    controller: _startDateController,
                                    decoration: InputDecoration(
                                      hintText: 'dd/mm/yyyy',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      // Your DateInputFormatter(),
                                      DateInputFormatter(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // End Date Field with Date Label on top
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('End', style: TextStyle(fontSize: 16)),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          80.0), // Right padding for 'Date' label
                                  child: Text('Date',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(
                                  width: 200, // Width of the TextFormField
                                  child: TextFormField(
                                    controller: _endDateController,
                                    decoration: InputDecoration(
                                      hintText: 'dd/mm/yyyy',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      // Your DateInputFormatter(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Search Site button aligned to the right
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          // onPressed: searchSite,
                          onPressed: () {
                            searchSite(); // Your existing search functionality
                            Navigator.pop(
                                context); // Close the dialog after search
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Search Site'),
                              Icon(Icons
                                  .arrow_forward), // Add an arrow icon to match the design
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Button color
                            onPrimary: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
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
