import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository = UserRepository();
  UserModel? userModel;
  RxString token = "".obs;

  Future<void> loginIn(String email, String pass)async{
    final response = await userRepository.loginUser(email, pass);
    print(response);
    //await loginDate();
  }

  Future<void> loginDate()async{
    await userRepository.loginGetDate();
  }


}