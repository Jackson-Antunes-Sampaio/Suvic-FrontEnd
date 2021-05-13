
import 'package:get/get.dart';

class CreditCardController extends GetxController{

  RxBool card = true.obs;
  List<String> cardNumber =["5500112233445566", "5533112233447788"].obs;
  //RxString cardNumber = '5500112233445566'.obs;
  RxString expiryDate = '11/2023'.obs;
  RxString cardHoldername = 'Jackson Antunes'.obs;
  RxString cvvCode = '123'.obs;

  RxString newCardNumber = "".obs;
  RxString newExpiryDate = ''.obs;
  RxString newCardHoldername = ''.obs;
  RxString newCvvCode = ''.obs;


  bool showBackView = false;
  RxBool selected = true.obs;
}