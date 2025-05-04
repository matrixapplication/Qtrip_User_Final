import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  late Failure failure;

  ErrorHandler.handle(Exception exception) {
    if (exception is DioError) {
      failure = _handleDioError(exception);
    } else {
      failure = ErrorType.unKnown.getFailure();
    }
  }

  Failure _handleDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ErrorType.connectTimeOut.getFailure();
      case DioErrorType.sendTimeout:
        return ErrorType.sendTimeOut.getFailure();
      case DioErrorType.receiveTimeout:
        return ErrorType.receiveTimeOut.getFailure();
      case DioErrorType.badResponse:
        {
          if (dioError.response?.statusMessage != null && dioError.response?.statusCode != null) {
            return Failure(dioError.response!.statusCode!, dioError.response!.data["message"]);
          } else {
            return ErrorType.unKnown.getFailure();
          }
        }
      case DioErrorType.cancel:
        return ErrorType.cancel.getFailure();
      case DioErrorType.unknown:
        return ErrorType.unKnown.getFailure();
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}

extension ErrorTypeException on ErrorType {
  Failure getFailure() {
    switch (this) {
      case ErrorType.connectTimeOut:
        return Failure(StatusCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case ErrorType.cancel:
        return Failure(StatusCode.cancel, ResponseMessage.cancel);
      case ErrorType.receiveTimeOut:
        return Failure(StatusCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case ErrorType.sendTimeOut:
        return Failure(StatusCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case ErrorType.noInternetConnection:
        return Failure(StatusCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case ErrorType.unKnown:
        return Failure(StatusCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

enum ErrorType {
  cancel,
  connectTimeOut,
  receiveTimeOut,
  sendTimeOut,
  noInternetConnection,
  unKnown,
}

class StatusCode {
  static const int cancel = -1;
  static const int connectTimeOut = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int noInternetConnection = -5;
  static const int unKnown = -6;
  static const int wrongLoginData = -7;
}

class ResponseMessage {
  static const String cancel = "Request was cancelled, try again.";
  static const String connectTimeOut = "Time out error, try again.";
  static const String receiveTimeOut = "Receive time error, try again.";
  static const String sendTimeOut = "Time out error, try again.";
  static const String noInternetConnection = "قم بالتحقق من اتصالك باللإنترنت.";
  static const String unKnown = "حدث خطأ ما, حاول مجددا.";
}
