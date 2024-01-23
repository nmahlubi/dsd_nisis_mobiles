import 'dart:io';
import 'package:hive/hive.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import '../../auth_intercept/authorization_interceptor.dart';
import '../../domain/repository/household/household_details_repository.dart';
import '../../model/household/household_details_dto.dart';
import '../../shared/apiresponse.dart';
import '../../shared/apiresults.dart';
import '../../util/app_url.dart';
import '../../util/http_client_service.dart';
import 'package:http/http.dart' as http;

class HouseholdDetailsService{

  final client =
  InterceptedClient.build(interceptors: [AuthorizationInterceptor()]);
  final _httpClientService = HttpClientService();
  final _householdDetailRepository = HouseholdDetailsRepository();

  Future<ApiResponse> addHouseholdDetailOnline(
      HouseHoldDetailsDto houseHoldDetailsDto) async {
    return await _httpClientService.httpClientPost(
        "${AppUrl.nisisURL}/api/HouseholdProfiling/Add", houseHoldDetailsDto);

  }

  // Future<ApiResponse> addHouseholdDetail(
  //     HouseHoldDetailsDto houseHoldDetailsDto) async {
  //   ApiResponse apiResponse = ApiResponse();
  //   try {
  //     print('Sending data to server: $houseHoldDetailsDto');
  //     apiResponse = await addHouseholdDetailOnline(houseHoldDetailsDto);
  //     print('Received response from server: $apiResponse');
  //
  //     if (apiResponse.apiError == null) {
  //       ApiResults apiResults = (apiResponse.data as ApiResults);
  //       HouseHoldDetailsDto householdDetailDtoResponse =
  //       HouseHoldDetailsDto.fromJson(apiResults.data);
  //       apiResponse.data = householdDetailDtoResponse;
  //
  //       // Save data to Hive
  //       await _saveToLocalHive(householdDetailDtoResponse);
  //
  //       print('Saving household details locally.');
  //     }
  //   } on SocketException {
  //     print('SocketException occurred. Saving household details locally.');
  //     await _saveToLocalHive(houseHoldDetailsDto);
  //     apiResponse.data = _householdDetailRepository
  //         .getHouseholdDetailsById(houseHoldDetailsDto.profilingInstanceId!);
  //   } catch (error) {
  //     print('Error in addHouseholdDetail: $error');
  //   }
  //   return apiResponse;
  // }

  Future<void> _saveToLocalHive(HouseHoldDetailsDto data) async {
    final box = await Hive.openBox<HouseHoldDetailsDto>('household_details');
    await box.add(data);
  }
  Future<List<HouseHoldDetailsDto>> getLocalHouseholdDetails() async {
    final box = await Hive.openBox<HouseHoldDetailsDto>('household_details');
    return box.values.toList();
  }

  Future<void> addHouseholdDetail(Map<String, dynamic> formData) async {
    try {
      // Replace 'YOUR_ENDPOINT_URL' with the actual URL where you want to send the data
      final String endpointUrl = 'https://testportal.dsd.gov.za/msnisis/api/HouseholdProfiling/GetAll';

      // Make an HTTP POST request using the http package
      final response = await http.post(
        Uri.parse(endpointUrl),
        body: formData,
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Handle a successful response
        print('Data sent successfully: ${response.body}');
      } else {
        // Handle errors if the response status code is not 200
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to send data');
      }
    } catch (error) {
      // Handle any exceptions that might occur during the HTTP request
      print('Error sending data: $error');
      rethrow; // Re-throw the error for handling in the calling function
    }
  }
}

