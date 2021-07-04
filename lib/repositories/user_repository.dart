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
        // options: Options(followRedirects: false, validateStatus: (status) { return status! < 500; })
      );

      // final response1 = await dio?.post(
      //   API_URL + "users/",
      //   data: {
      //     "name": "user",
      //     "email": "user@user.com",
      //     "password": "123456",
      //     "permission": "Admin",
      //   },
      // );

      // print('Status de Create:' + response1!.statusCode.toString());

      print("cookie: ${response?.headers["set-cookie"]![0]}");

      var cookie = response?.headers["set-cookie"]![0];

      if (response?.statusCode == 200) {
        final storage = FlutterSecureStorage();
        await storage.write(key: "token", value: cookie);
        print("aquuuuuuuuuuuuuuuuuuuuuui");
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

  // Future<String> loginUser2(String email, String pass) async {
  //    try {
  //     Dio? dio = CustomDio().instance;
  //     //Dio dio = Dio();
  //
  //     dio?.options.headers["X-Authorization"] = "Bearer Jackson";
  //
  //     final response = await dio?.post(API_URL + "login",
  //         data: {
  //       "email" : email,
  //       "password" : pass,
  //     },
  //      // options: Options(followRedirects: false, validateStatus: (status) { return status! < 500; })
  //     );
  //
  //     print("message: ${response?.headers["set-cookie"]}");
  //
  //     var cookie = response?.headers["set-cookie"]![0];
  //
  //     if (response?.statusCode == 200) {
  //       print(cookie.toString());
  //       dio?.options.headers["Cookie"] = "$cookie";
  //       final response = await dio?.get(API_URL + "users/",);
  //       print("StatusCode: ${response?.statusCode}");
  //
  //       print("${response!.data}");
  //
  //       return "Usuario Logado!";
  //
  //     } else {
  //       return "Email e/ou Senha incorreto";
  //     }
  //   } catch (e) {
  //     return "Email e/ou Senha incorreto";
  //   }
  // }

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

// Future<UserModel> newPass(String email, String pass, String newPass) async {
//   try {
//     Dio dio = CustomDio.withAuthentication().instance!;
//     final response = await dio.put(API_URL + "users",
//         data: {"email": email, "password": pass, "newPassword": newPass});
//
//     if (response.statusCode == 200) {
//       //return await loginUser(email, newPass);
//     } else {
//     }
//   } catch (e) {
//   }
// }

// Future refreshToken() async {
//   try {
//     Dio dio = CustomDio.withAuthentication().instance!;
//     final response = await dio.post(API_URL + "users/refresh-token");
//
//     if (response.statusCode == 201) {
//       final storage = FlutterSecureStorage();
//       await storage.write(key: "token", value: response.data["token"]);
//
//       return UserModel.fromJson(response.data["user"]);
//     } else {
//     }
//   } catch (e) {
//     return e.response.data["message"];
//   }
// }
}
