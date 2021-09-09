import 'package:covid_19/models/pagarme_model.dart';
import 'package:covid_19/repositories/credit_card_repository.dart';
import 'package:get/get.dart';

enum StateCreditCard { LOADING, FORMCARD, FORMDATA, SUCCESS, FAIL }
enum StateProductCard { LOADING, IDL, SUCCESS, FAIL }

class CreditCardController extends GetxController {
  Rx<StateCreditCard> stateCreditCard = StateCreditCard.FORMCARD.obs;
  Rx<StateProductCard> stateProductCard = StateProductCard.IDL.obs;
  RxBool cardSave = false.obs;
  Rx<PagarMeModel> pagarMeModel = PagarMeModel().obs;

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

  Future<bool> transactionsPagarme() async {
    stateProductCard.value = StateProductCard.LOADING;
    try {
      await creditCardRepository.postTransactionsPagarme(pagarMeModel.toJson());
      stateProductCard.value = StateProductCard.IDL;
      return true;
    } catch (e) {
      stateProductCard.value = StateProductCard.IDL;
      // stateProductCard.value = StateProductCard.FAIL;
      return false;
    }
  }
}
