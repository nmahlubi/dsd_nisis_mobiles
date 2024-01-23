import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'house_hold/house_hold_profile.dart';

import 'dashboard_page.dart';
import '../../../shared/date_input_formatter.dart';
import '../../../service/intake/search_sites.dart';

class WorkListPage extends StatefulWidget {
  const WorkListPage({Key? key}) : super(key: key);

  @override
  State<WorkListPage> createState() => _WorkListPageState();
}

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
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      siteId: int.tryParse(json['siteId'].toString()) ?? 0,
      wardId: int.tryParse(json['wardId'].toString()) ?? 0,
      siteName: json['siteName'] as String? ?? 'Unknown',
      siteAlternativeName: json['siteAlternativeName'] as String?,
      isActive: json['isActive'] as bool? ?? false,
      dateCreated: json['dateCreated'] as String? ?? 'Unknown',
      province: json['province'] as String? ?? 'Unknown Province',
      district: json['district'] as String? ?? 'Unknown District',
      localMunicipality:
          json['localMunicipality']?.toString() ?? 'Unknown Municipality',
      ward: json['ward'] as String? ?? 'Unknown Ward',
      createdBy: json['createdBy'] as String? ?? 'Unknown',
      responsible: json['responsible']?.toString() ?? 'Unknown Responsible',
    );
  }
}

class _WorkListPageState extends State<WorkListPage> {
  SharedPreferences? preferences;
  List<Site> savedSites = [];
  late List<bool> isExpanded; // Declare isExpanded as late

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
    await fetchSavedSites(); // Fetch saved sites after initializing preferences
  }

  Future<void> fetchSavedSites() async {
    final String worklistKey = 'worklist_sites';
    List<String> savedSitesJson = preferences?.getStringList(worklistKey) ?? [];
    setState(() {
      savedSites =
          savedSitesJson.map((jsonString) => jsonToSite(jsonString)).toList();
    });
  }

  Site jsonToSite(String jsonString) {
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return Site.fromJson(jsonData);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializePreference(); // Initialize SharedPreferences
      await fetchSavedSites(); // Fetch saved sites
      await fetchSearchData();
      setState(() {
        isExpanded = List.generate(
            savedSites.length, (index) => false); // Initialize isExpanded
      });
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
    setState(() {
      selecteLocalMunicipality = localMunicipality;
      wardsSearch =
          provinceService.extractWards(localMunicipalitiesD, localMunicipality);
      selecteWardNumber = null; // Reset selected ward number
    });
  }

  // ends here

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
          title: Row(
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
          padding: const EdgeInsets.all(5),
          child: Form(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFE3C263)),
                            ),
                            child: Text('Back',
                                style: TextStyle(color: Colors.black)),
                          ),
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
                          CircleAvatar(
                            radius: 15.0, // Reduced from the default 20.0
                            backgroundColor: Colors.purple,
                            child: Text(
                              'PM',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    12.0, // Optional: You might want to reduce the font size as well
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Center(
                        child: Text(
                          'WorkList',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFFE3C263),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF036FE3)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12)), // More rounded corners
                          ),
                          minimumSize: MaterialStateProperty.all(
                              Size(double.infinity, 60)), // Set the height here
                          elevation: MaterialStateProperty.all(
                              4), // Add elevation for shadow
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical:
                                      20)), // Adjust padding for a taller look
                        ),
                        onPressed: () {
                          // TODO: Add your onPressed logic here
                                                          _showSearchSitePopup(context);
                                fetchSearchData();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Search WorkList Site',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // Bold text
                                fontSize: 18, // Larger font size
                              ),
                            ),
                            SizedBox(
                                width:
                                    10), // Adjust space between text and icon if needed
                            Icon(Icons.search,
                                color: Colors.white, size: 30), // Larger icon
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Work list Sites",
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
                        itemCount: savedSites.length,
                        itemBuilder: (context, index) {
                          final site = savedSites[index];
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
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                ],
                              ),
                              // Assuming you have a mechanism to expand/collapse additional details
                              Visibility(
                                visible: isExpanded[
                                    index], // Ensure 'isExpanded' list is defined in your state
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(height: 40),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  double width = constraints.maxWidth;

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Container(
                                      //   width: width * 0.10, // 10% of available width
                                      //   height: 34.0,
                                      //   child: ElevatedButton(
                                      //     onPressed: () {
                                      //       _showSuccessDialog(context);
                                      //     },
                                      //     child: Icon(Icons.delete,
                                      //         size: 14.0, color: Colors.white),
                                      //     style: ElevatedButton.styleFrom(
                                      //       primary: Color(0xFF036FE3),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                          width: 5), // Spacing between buttons
                                      Container(
                                        width: width *
                                            0.40, // 40% of available width
                                        height: 38.0,
                                        child: ElevatedButton(
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
                                                    color: Colors.white),
                                              ), // Correct usage
                                              SizedBox(width: 6),
                                              Icon(
                                                isExpanded[index]
                                                    ? Icons.arrow_upward
                                                    : Icons
                                                        .arrow_forward, // Correct usage
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 10), // Spacing between buttons
                                      Container(
                                        width: width *
                                            0.47, // 50% of available width
                                        height: 38.0,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      House_ProfilePage()),
                                            );
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // This centers the children vertically
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center, // This centers the Text widgets vertically inside the Column
                                                children: [
                                                  Text(
                                                    "Household",
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Profiling",
                                                    style: TextStyle(
                                                        fontSize: 11.0,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_forward,
                                                  size: 14.0,
                                                  color: Colors.white),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF036FE3),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 10), // Adjust padding
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
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
                              )),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
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
      ),
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
                          }
                        : null, // Disable onChanged when there are no items
                  ),
                  // SizedBox(height: 20),
                  // DropdownButtonFormField<String>(
                  //   decoration: InputDecoration(
                  //     labelText: 'Ward',
                  //     hintText: 'Please select',
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   value: selecteWardNumber,
                  //   items: wardsSearch.map((ward) {
                  //     return DropdownMenuItem<String>(
                  //       value: ward['wardNumber'],
                  //       child: Text('Ward ${ward['wardNumber']}'),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       selecteWardNumber = newValue;
                  //     });
                  //   },
                  // ),

                  SizedBox(height: 20),
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
                                     // FilteringTextInputFormatter.digitsOnly,
                                      // Your DateInputFormatter(),
                                      //DateInputFormatter(),
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
                                     // FilteringTextInputFormatter.digitsOnly,
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

  _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.all(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check, color: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        'Site removed from your Worklist',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('successfully'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(Widget child, {Function()? onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0x802196F3),
      child: InkWell(
        onTap: onTap != null ? () => onTap() : () {},
        child: child,
      ),
    );
  }
}
