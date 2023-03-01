
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vipul_assignment/network/retrofit.dart';

class BaseNetwork {
  late Retrofit retrofit;
  final String? contentType;
  final BuildContext _context;
  CancelToken? token;
  String? baseUrl;

  cancelCall() {
    if (token != null) token!.cancel("cancelled");
    token = CancelToken();
  }

  BaseNetwork(
    this._context, {
    this.contentType,
  }) {
    token = CancelToken();
    final logging = LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    );

    final baseOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 30000),
      receiveTimeout: const Duration(seconds: 30000),
      followRedirects: true,
      validateStatus: (status) {
        return status == null ? false : status <= 500;
      },
    );

    baseOptions.headers = {
      "content-type": contentType ?? "application/json",
    };

    Dio _dio = Dio(baseOptions);
    _dio.interceptors.add(logging);

    if (baseUrl != null) {
      retrofit = Retrofit(_dio, baseUrl: baseUrl);
    } else {
      retrofit = Retrofit(_dio);
    }
  }
}
