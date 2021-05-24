import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();
  UserModel? user;
  RxString token = "".obs;

  Future<String> loginIn(String email, String pass)async{
    final response = await userRepository.loginUser(email, pass);
    await loginDate();
    return response;

  }

  Future<void> loginDate()async{
    user = await userRepository.loginGetDate();

    print("aqui $user");
  }


}