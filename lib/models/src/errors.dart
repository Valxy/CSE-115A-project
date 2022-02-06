class AppException implements Exception {
  final String message;
  final String prefix;
  AppException({required this.message, required this.prefix});

  @override
  String toString() {
    return "$prefix$message";
  }
}

class InvalidDateException extends AppException {
  InvalidDateException({message})
      : super(
          message: message,
          prefix: "Invalid Date",
        );
}

class FetchDataException extends AppException {
  FetchDataException({message})
      : super(
          message: message,
          prefix: "Error During Communication: ",
        );
}

class BadRequestException extends AppException {
  BadRequestException({message})
      : super(
          message: message,
          prefix: "Invalid Request: ",
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException({message})
      : super(
          message: message,
          prefix: "Unauthorized: ",
        );
}

class InvalidInputException extends AppException {
  InvalidInputException({message})
      : super(
          message: message,
          prefix: "Invalid Input: ",
        );
}
