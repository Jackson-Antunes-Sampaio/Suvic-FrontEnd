import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class CustomDio{
  Dio _dio;
  CustomDio(){
    _dio=Dio();
  }

  CustomDio.withAuthentication(){
    _dio = Dio();
    _dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  Dio get instance => _dio;

  void _onRequest(RequestOptions options)async{
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    //print(token);
    options.headers["x-access-token"] = token;
  }

  _onError(DioError e) {

    return e;
  }

  void _onResponse(Response e) {
    print(e.statusCode);
  }
}