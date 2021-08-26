import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();
  UserModel? user;
  RxString token = "".obs;
  RxBool isLogged = false.obs;
  RxBool loading = false.obs;
  String message = "";

  Future<String> loginIn(String email, String pass) async {
    try {
      loading.value = true;
      final response = await userRepository.loginUser(email, pass);
      await loginDate();
      loading.value = false;
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> loginDate() async {
    try {
      user = await userRepository.loginGetDate();
      isLogged.value = true;
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      final storage = FlutterSecureStorage();
      await storage.delete(key: "token");
      await userRepository.logout();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> singUp(String name, String email, String cpf, String pass,
      String confirmPass, String birthdate) async {
    loading.value = true;
    message = "";


    if(name.length <3 || cpf.length != 14 || email.length <3 || birthdate.length != 10 || pass == "" || confirmPass == ""){
      message = "Campo(s) vazio(s) e/ou inválido(s)";
      loading.value = false;
      return false;
    }

    if(pass != confirmPass){
      message = "Senhas diferentes.";
      loading.value = false;
      return false;
    }


    try {
      String date = "${birthdate.split("/").last}-${birthdate.split("/")[1]}-${birthdate.split("/").first}";
      String response = await userRepository.postSingUp({
        "civilName" : name,
        "cpf" : cpf.replaceAll(".", "").replaceAll("-", ""),
        "email" : email,
        "password" : pass,
        "birthdate" : date
      });
      message = response;
      print("aquiii");
      loading.value = false;
      return true;

    } catch (e) {
      print(e);
      message = "erro";
      loading.value = false;
      return false;
    }
  }
}
