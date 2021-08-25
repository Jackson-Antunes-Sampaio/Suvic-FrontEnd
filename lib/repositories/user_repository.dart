import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {

  Future<String> loginUser(String email, String pass) async {
    try {
      Dio? dio = CustomDio().instance;
      final response = await dio?.post(
        API_URL + "login",
        data: {
          "email": email,
          "password": pass,
        },
      );

      var cookie = response?.headers["set-cookie"]![0];

      if (response?.statusCode == 200) {
        final storage = FlutterSecureStorage();
        await storage.write(key: "token", value: cookie);
        return "Usuario Logado!";
      } else {
        print("Erro 1: Email e/ou Senha incorreto");
        return "Email e/ou Senha incorreto";
      }
    } catch (e) {
      print("Erro 2: Email e/ou Senha incorreto");
      return "Email e/ou Senha incorreto";
    }
  }

  Future<UserModel> loginGetDate() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      if(token == null){
        return Future.error("error");
      }
      print(token);
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users");

      print("Returno api: ${response.data}");

      return UserModel.fromJson(response.data);
    } catch (e) {
      print("Erro repositorio: $e");
      return Future.error("error");
    }
  }

  Future logout() async {
    try {
      Dio? dio = CustomDio().instance;

      final response = await dio!.post(API_URL + "logout");

      print("${response.data}");
    } catch (e) {
      print(e);
    }
  }

  Future<String> postSingUp(Map<String, dynamic> map) async {
    print(map);
    try {
      Dio? dio = CustomDio().instance;
      final response = await dio?.post(
        API_URL + "users",
        data: map
      );

      if (response?.statusCode == 200) {
        print(response?.data);
        return "Usuario criado com sucesso.";
      } else {
        return "Erro";
      }
    } catch (e) {

      return "Erro";
    }
  }



}
