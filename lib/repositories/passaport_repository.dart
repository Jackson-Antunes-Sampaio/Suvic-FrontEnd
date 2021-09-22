import 'package:covid_19/models/passaport_model.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PassaportRepository {
  // Future<List<PassaportModel>>
  getpassaport() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users");

      return PassaportModel.fromJson(response.data);
      // return (response.data as List).map<PassaportModel>((e) {
      //   return PassaportModel.fromJson(e);
      // }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future<String> postPassaport(PassaportModel passpaort) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      Map<String, dynamic> map = {
        "civilName": passpaort.civilName,
        "cpf": passpaort.cpf,
        "email": passpaort.email,
        "password": passpaort.password,
        "birthdate": passpaort.birthdate,
        "documentFront": passpaort.documentFront!,
      };
      final response = await dio.post(API_URL + "users", data: map);

      print(map);

      return token!;

      // print(map);

      // print("${response.data}");

      // if (response.data["message"] != null) {
      //   return response.data["message"];
      // } else {
      //   return "Error";
      // }
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }
}
