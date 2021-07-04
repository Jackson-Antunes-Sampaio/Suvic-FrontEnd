
import 'package:covid_19/repositories/credit_card_repository.dart';
import 'package:get/get.dart';


enum StateCreditCard {LOADING, FORMCARD, FORMDATA, SUCCESS, FAIL}
class CreditCardController extends GetxController{

  Rx<StateCreditCard> stateCreditCard = StateCreditCard.FORMCARD.obs;
  RxBool cardSave = false.obs;

  CreditCardRepository creditCardRepository = CreditCardRepository();

  RxBool card = true.obs;
  //List<String> cardNumber =["5500112233445566", "5533112233447788"].obs;
  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHoldername = ''.obs;
  RxString cvvCode = ''.obs;

  RxString newCardNumber = "".obs;
  RxString newExpiryDate = ''.obs;
  RxString newCardHoldername = ''.obs;
  RxString newCvvCode = ''.obs;


  bool showBackView = false;
  RxBool selected = true.obs;


  Future<void> transactionsPagarme(Map<String, dynamic> map)async{
    stateCreditCard.value = StateCreditCard.LOADING;
    try{
      await creditCardRepository.postTransactionsPagarme(map);
      stateCreditCard.value = StateCreditCard.SUCCESS;
    }catch(e){
      stateCreditCard.value = StateCreditCard.FAIL;
      print("ERRO: $e");
    }

  }
}