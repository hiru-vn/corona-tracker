class ErrorData {
  int code;
  String type;
  String message;
  ErrorData({this.code, this.type, this.message});
  factory ErrorData.fromJson(Map<String, dynamic> map) {
    return ErrorData(
      code: map['code'],
      type: map['type'],
      message: map['message'],
    );
  }
  factory ErrorData.fromData(String msg) {
    return ErrorData(message: msg, type: 'local', code: 400);
  }
}

abstract class Result {}

class ResultSuccess<T> extends Result {
  final T dataSuccess;
  ResultSuccess(this.dataSuccess);
}

class ResultError<T> extends Result {
  final String msg;
  final Exception exception;
  final T data;
  ResultError({this.msg, this.exception, this.data});
}

class EmptyError extends ResultError {}
