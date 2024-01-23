import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HouseholdData extends StatefulWidget {
  final Map<String, dynamic> data;
  final String? description;
  final String? dateProfiled;
  final String? eaNumber;
  final String? householdQuestionId;
  final String? profileToolId;
  final String? structureType;
  final String? dwellingUnitAddress;
  final String? dewllingDescription;
  final String? dwellingUnitNumber;
  final String? householdNumber;
  final String? dwellingCoordinates;
  var provinceId;
  var profilingToolId;
  var dwellingUnitDescription;
  var dateLastModified;
  var modifiedBy;
  var profilingMethodId;
  var profilingDate;
  var personId;
  var createdBy;

   HouseholdData({super.key, this.description, this.dateProfiled, this.eaNumber, this.householdQuestionId, this.profileToolId, this.structureType, this.dwellingUnitAddress, this.dewllingDescription, this.dwellingUnitNumber, this.householdNumber, this.dwellingCoordinates,  required this.data});

  @override
  State<HouseholdData> createState() => _HouseholdDataState();
}

class _HouseholdDataState extends State<HouseholdData> {
  List<Map<String, dynamic>> siteData = [];


  @override
  void initState() {
    super.initState();
    fetchAndProcessData();
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
  @override
  Widget build(BuildContext context) {
    return
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
                      title: Text('Site Name: ${site['siteName']}'),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              Text('Date Profiled'),
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
                              Text('HHID: ${widget.data['hhid'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Address: ${widget.data['dwelling_Unit_Address'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Description: ${widget.data['dwelling_Unit_Description'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('HHID: ${widget.data['hhid'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Address: ${widget.data['dwelling_Unit_Address'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Description: ${widget.data['dwelling_Unit_Description'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Province: ${site['provinces']['description']}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Local Municipality: ${site['provinces']['districts'][index]['localMunicipalities'][index]['description']}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Municipality: ${site['provinces']['districts'][index]['description']}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Ward: ${site['provinces']['districts'][index]['localMunicipalities'][index]['ward']['description']}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('Site Name: ${site['siteName']}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('HHID: ${widget.data['hhid'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Address: ${widget.data['dwelling_Unit_Address'] ?? 'Not Available'}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Dwelling Unit Description: ${widget.data['dwelling_Unit_Description'] ?? 'Not Available'}'),
                              SizedBox(
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
          )
      );
  }
}


