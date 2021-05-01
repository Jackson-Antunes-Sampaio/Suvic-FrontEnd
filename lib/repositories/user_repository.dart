
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';


class UserRepository {



  Future<String> loginUser(String email, String pass) async {
    try {
      //Dio dio = CustomDio().instance;
      Dio dio = Dio();

      print(API_URL + "login");
      final response = await dio.post(API_URL + "login", data: {
        "email" : email,
        "password" : pass,
      });

      print("aqui");

      if (response.statusCode == 200) {
        return "Ok";
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error 2";
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