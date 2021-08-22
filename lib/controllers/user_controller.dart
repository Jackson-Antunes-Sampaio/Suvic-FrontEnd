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

  Future<String> loginIn(String email, String pass) async {
    loading.value = true;
    final response = await userRepository.loginUser(email, pass);
    await loginDate();
    loading.value = false;
    return response;
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
}
