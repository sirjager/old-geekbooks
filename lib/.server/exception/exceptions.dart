class BaseExceptions implements Exception {
  final String message;
  final String prefix;
  final String url;
  BaseExceptions(this.message, this.prefix, this.url);
}

class ApiNotRespondingException extends BaseExceptions {
  ApiNotRespondingException(String message, String url)
      : super(message, 'Taking too much time', url);
}

class BadRequestException extends BaseExceptions {
  BadRequestException(String message, String url)
      : super(message, 'Bad Request', url);
}

class UnAuthorizedException extends BaseExceptions {
  UnAuthorizedException(String message, String url)
      : super(message, 'Unauthorized Request', url);
}

class NotFoundException extends BaseExceptions {
  NotFoundException(String message, String url)
      : super(message, 'Not Found', url);
}

class TooManyRequestException extends BaseExceptions {
  TooManyRequestException(String message, String url)
      : super(message, 'Too Many Request', url);
}

class ServerErrorException extends BaseExceptions {
  ServerErrorException(String message, String url)
      : super(message, 'Internal Server Error', url);
}

class FetchDataException extends BaseExceptions {
  FetchDataException(String message, String url)
      : super(message, 'Unable to process your request at this moment', url);
}
