import 'package:dio/dio.dart';

class DioException implements Exception {
  late String errorMessage;

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = "Request to the server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = "Connection time out";
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receiving time out occurred";
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Sending time out occurred";
        break;
      case DioErrorType.badResponse:
        errorMessage = _handleStatusCode(dioError.response?.statusCode);
        break;
      case DioErrorType.unknown:
        if (dioError.message!.contains('SocketException')) {
          errorMessage = "No internet connection";
          break;
        }
        errorMessage = "Unexpected error occurred";
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "User already exist";
      case 401:
        return "Authentication failed";
      case 403:
        return "Access denied";
      case 404:
        return "Requested resource does not exist";
      case 500:
        return "Internal server error";
      default:
        return "Oops something went wrong";
    }
  }

  @override
  String toString() => errorMessage;
}
