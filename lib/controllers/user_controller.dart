import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();
  //final userModel = UserModel().obs;
  RxString token = "".obs;

  loginIn(String email, String pass)async{
    final response = await userRepository.loginUser(email, pass);

    print(response);

  }
}