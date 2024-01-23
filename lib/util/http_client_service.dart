import 'dart:convert';
import '../auth_intercept/authorization_interceptor.dart';
import '../shared/apierror.dart';
import '../shared/apiresponse.dart';
import '../shared/apiresults.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class HttpClientService {
  final client =
      InterceptedClient.build(interceptors: [AuthorizationInterceptor()]);
  Future<ApiResponse> httpClientPost(String url, Object bodyParameter) async {
    ApiResponse apiResponse = ApiResponse();
    final response = await client.post(Uri.parse(url),
        body: json.encode(bodyParameter),
        headers: {'Content-Type': 'application/json'});
    switch (response.statusCode) {
      case 200:
        ApiResults apiResults = ApiResults.fromJson(json.decode(response.body));
        apiResponse.data = apiResults;
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
    return apiResponse;
  }

  Future<ApiResponse> httpClientGet(String url) async {
    ApiResponse apiResponse = ApiResponse();
    final response = await client.get(Uri.parse(url));
    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body);
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
    return apiResponse;
  }
}
