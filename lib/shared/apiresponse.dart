// class ApiResponse {
//   // _data will hold any response converted into
//   // its own object. For example user.
//   late Object? data;
//   // _apiError will hold the error object
//   Object? _apiError;
//
//   Object? get apiError => _apiError != null ? _apiError as Object : null;
//
//   set apiError(Object? error) => _apiError = error;
// }

class ApiResponse implements Comparable<ApiResponse> {
  late Object? data;
  Object? _apiError;

  Object? get apiError => _apiError != null ? _apiError as Object : null;

  set apiError(Object? error) => _apiError = error;

  @override
  int compareTo(ApiResponse other) {
    // Compare based on the data field if both are non-null
    if (data != null && other.data != null) {
      return (data.hashCode - other.data.hashCode).sign;
    }

    // If data is null on one side, prioritize the non-null one
    if (data == null && other.data != null) {
      return -1;
    } else if (data != null && other.data == null) {
      return 1;
    }

    // If both data fields are null, compare based on _apiError
    if (apiError != null && other.apiError != null) {
      return (apiError.hashCode - other.apiError.hashCode).sign;
    }

    // If _apiError is null on one side, prioritize the non-null one
    if (apiError == null && other.apiError != null) {
      return -1;
    } else if (apiError != null && other.apiError == null) {
      return 1;
    }

    // If both _apiError fields are null, consider both objects equal
    return 0;
  }
}

