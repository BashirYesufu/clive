import 'package:dio/dio.dart';

class BaseApiResponse<T> {
  T? data;
  String? status;
  String? message;

  BaseApiResponse({
    this.data,
    this.status,
    this.message,
  });

  factory BaseApiResponse.fromJson(Response<dynamic>? json,{bool useNestedParam = false,}) => BaseApiResponse(
    data: useNestedParam ? json?.data["data"] : json?.data,
    status: useNestedParam ? json?.data["status"] : '',
    message: useNestedParam ? json?.data["message"] : '',
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "status": status,
    "message": message,
  };
}