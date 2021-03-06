


import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

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

      if(response.statusCode == 200){
        return response.data.toString();
      }else{
        return Future.error("error");
      }


    }catch(e){
      print("ERRO ${e}");
      return Future.error("error");
    }
  }

}