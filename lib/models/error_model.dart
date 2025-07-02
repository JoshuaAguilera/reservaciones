import 'dart:convert';

ErrorModel ErrorFromJson(String str) => ErrorModel.fromJson(json.decode(str));
List<String> CandenasFromJson(List<dynamic> str) =>
    List<String>.from(str.map((x) => x.toString()));

class ErrorModel {
  String? requestId;
  String? title;
  String? message;
  String? status;
  String? code;
  List<String>? listErrors;

  ErrorModel({
    this.requestId,
    this.title,
    this.code,
    this.listErrors,
    this.message,
    this.status,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      requestId: json['request_Id'],
      title: json['title'] ?? "",
      code: json['code'] ?? "",
      listErrors: json['listErrors'] != null
          ? json['listErrors'] != '[]'
              ? CandenasFromJson(json['listErrors'])
              : List<String>.empty()
          : List<String>.empty(),
      status: json['status'] ?? "",
      message: json['message'] ?? "",
    );
  }
}
