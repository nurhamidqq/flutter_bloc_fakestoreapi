import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final _message;
  final _prefix;

  ServerException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ServerException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ServerException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ServerException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ServerException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

dynamic exceptionHandling(http.Response response) {
  switch (response.statusCode) {
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw UnauthorisedException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
