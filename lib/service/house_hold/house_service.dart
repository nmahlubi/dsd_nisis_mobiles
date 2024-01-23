import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http/intercepted_client.dart';

import '../../auth_intercept/authorization_interceptor.dart';
import '../../domain/repository/household/household_repository.dart';
import '../../domain/repository/intake/person_repository.dart';
import '../../model/household/house_dto.dart';
import '../../shared/apierror.dart';
import '../../shared/apiresponse.dart';
import '../../shared/apiresults.dart';
import '../../util/app_url.dart';
import '../../util/http_client_service.dart';
import 'package:http/http.dart' as http;

class HouseholdService {
  final client =
      InterceptedClient.build(interceptors: [AuthorizationInterceptor()]);
  final _householdRepository = HouseholdRepository();
  final _personRepository = PersonRepository();
  final _httpClientService = HttpClientService();

  Future<ApiResponse> addHouseholdOnline(HouseHoldDto houseHoldDto) async {
    return await _httpClientService.httpClientPost(
        "${AppUrl.intakeURL}/Person/Add", houseHoldDto);
  }

  // Future<ApiResponse> getHouseholdProfilingById(int? profilingInstanceId) async {
  //   ApiResponse apiResponse = ApiResponse();
  //
  //   try {
  //     final response = await client.get(Uri.parse("${AppUrl.nisisURL}/$profilingInstanceId"));
  //
  //     switch (response.statusCode) {
  //       case 200:
  //         HouseHoldDto userDtoResponse =
  //         HouseHoldDto.fromJson(json.decode(response.body));
  //         apiResponse.data = userDtoResponse;
  //         break;
  //       default:
  //         apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
  //         break;
  //     }
  //   } on SocketException {
  //     apiResponse.apiError = ApiError(error: "Connection Error. Please retry");
  //   }
  //   return apiResponse;
  // }

  Future<ApiResponse> addHousehold(HouseHoldDto houseHoldDto) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      apiResponse = await addHouseholdOnline(houseHoldDto);

      if (apiResponse.apiError == null) {
        ApiResults apiResults = (apiResponse.data as ApiResults);
        HouseHoldDto houseHoldDtoResponse =
            HouseHoldDto.fromJson(apiResults.data);
        apiResponse.data = houseHoldDtoResponse;
        _householdRepository.saveHousehold(houseHoldDto, 8);
      }
    } on SocketException {
      _householdRepository.saveHousehold(houseHoldDto, 8);
      apiResponse.data = _householdRepository
          .getProfilingInstanceById(houseHoldDto.profilingInstanceId!);
    }
    return apiResponse;
  }
}
