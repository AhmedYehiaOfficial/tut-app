import 'package:dio/dio.dart';
import 'package:flutter_adv/data/network/Failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      //dio error so its error from response of the api or from dio itself
      failure = _handleError(error);
    } else {
//default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();

    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}
enum DataSource {
  SUCCESS,
  NO_CONTENT,
  NOT_FOUND,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHRIZED,
  INTERNET_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CASH_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHRIZED:
        return Failure(ResponseCode.UNAUTHRIZED, ResponseMessage.UNAUTHRIZED);

      case DataSource.INTERNET_SERVER_ERROR:
        return Failure(ResponseCode.INTERNET_SERVER_ERROR,
            ResponseMessage.INTERNET_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CASH_ERROR:
        return Failure(ResponseCode.CASH_ERROR, ResponseMessage.CASH_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // SECCESS DATA
  static const int NO_CONTENT = 201; //success with no data
  static const int BAD_REQUEST = 400; //failure api rejected request
  static const int UNAUTHRIZED = 401; //failure user is not authenticated
  static const int FORBIDDEN = 403; //failure api rejected request
  static const int NOT_FOUND = 404; //failure page not found
  static const int INTERNET_SERVER_ERROR = 500; //failu crash in server side

// local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CASH_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; // success DATA
  static const String NO_CONTENT = "success"; //success with no data
  static const String BAD_REQUEST =
      "bad request try again latre"; //failure api rejected request
  static const String UNAUTHRIZED =
      "user is unauthorized try again later"; //failure user is not authenticated
  static const String FORBIDDEN =
      "forbidden request try again later"; //failure api rejected request
  static const String NOT_FOUND = "page not found"; //failure page not found
  static const String INTERNET_SERVER_ERROR =
      "some thing went wrong try again later"; //failure crash in server side

// local status code
  static const String CONNECT_TIMEOUT = "time out error try again later";
  static const String CANCEL = "request was canceled try again later";
  static const String RECIEVE_TIMEOUT = "time out error try again later";
  static const String SEND_TIMEOUT = "time out error try again later";
  static const String CASH_ERROR = "cash error try again later";
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection";
  static const String DEFAULT = "some thing went wrong try again later";
}
class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}