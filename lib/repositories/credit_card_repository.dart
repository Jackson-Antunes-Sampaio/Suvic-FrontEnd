

import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreditCardRepository {

  Future<String> postTransactionsPagarme(Map<dynamic, dynamic> data)async{

    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      print("Data ${data}");
      final response = await dio.post(API_URL + "pay/", data: data);

      print("Response: ${response.statusCode}");

      return response.data.toString();
    }catch(e){
      print("ERRO ${e}");
      return Future.error("error");
    }
  }

}