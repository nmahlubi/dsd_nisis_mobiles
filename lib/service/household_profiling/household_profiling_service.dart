import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

import '../../auth_intercept/authorization_interceptor.dart';
import '../../model/household/house_dto.dart';
import '../../model/household/profile_model.dart';
import '../../shared/apierror.dart';
import '../../shared/apiresponse.dart';
import '../../util/app_url.dart';


class ProfilingInstanceService {
  final client =
  InterceptedClient.build(interceptors: [AuthorizationInterceptor()]);

  Future<ApiResponse> getProfilingAll() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await client
          .get(Uri.parse("${AppUrl.nisisURL}/api/HouseholdProfiling/GetAll"));


      switch (response.statusCode) {
        case 200:
          List<HouseHoldDto> offenceTypeDtoResponse =
          (json.decode(response.body) as List)
              .map((data) => HouseHoldDto.fromJson(data))
              .toList();
          apiResponse.data = offenceTypeDtoResponse;
          break;
        default:
          apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
          break;
      }
    } on SocketException {
      apiResponse.apiError = ApiError(error: "Connection Error. Please retry");
    }
    return apiResponse;
  }


}



