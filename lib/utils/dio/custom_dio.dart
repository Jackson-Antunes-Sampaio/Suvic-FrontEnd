import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomDio {
  Dio? _dio;
  CustomDio() {
    _dio = Dio();

    (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Dio? get instance => _dio;

  CustomDio.withAuthentication() {
    _dio = Dio();

    _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  void _onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    options.headers["Cookie"] = token;

    //options.headers["x-access-token"] = token;
  }

  _onError(DioError e, ErrorInterceptorHandler handler) {
    print("Erro: $e");
    return e;
  }

  void _onResponse(Response e, ResponseInterceptorHandler handler) {
    print(e.statusCode);
  }
}
