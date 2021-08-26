import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterApplicatorRepository {

  Future<String> postRegisterApplicator(String cpf)async{

    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.post(API_URL + "clinics/staff", data: {
        "target" : "$cpf",
        "permission" : "Applicator"
      });
      print(response);
      if(response.data["error"] != null){
        return "Usuario não encontrado no banco de dados.";
      }else{
        return response.data.toString();
      }

    }catch(e){
      print(e);
      return Future.error("error");
    }
  }

}