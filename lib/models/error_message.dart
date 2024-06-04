// 错误信息实体
class ErrorMessageModel {
  int? statusCode;
  String? error;
  String? message;

  ErrorMessageModel({this.message, this.statusCode, this.error});

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      message: json['statusCode'] as String?,
      error: json['error'] as String?,
      statusCode: json['statusCode'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "error": error,
        "message": message,
      };
}
