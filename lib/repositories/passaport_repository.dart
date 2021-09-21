import 'package:covid_19/models/passaport_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PassaportRepository {
  Future<List<PassaportModel>> getpassaport() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users");

      return (response.data as List).map<PassaportModel>((e) {
        return PassaportModel.fromJson(e);
      }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future<String> postPassaport(String civilName, String cpf, String email,
      String senha, int data, String? documenteFront) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      Map<String, dynamic> map = {
        "civilName": civilName,
        "cpf": cpf,
        "email": email,
        "password": senha,
        "birthdate": data,
        "documentFront": documenteFront,
      };
      final response = await dio.post(API_URL + "users", data: map);
      print("${response.data}");

      if (response.data["message"] != null) {
        return response.data["message"];
      } else {
        return "Error";
      }
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }
}
