
import 'package:dio/dio.dart';
import 'package:suvic_app/models/pagarme_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class PagarMeRepository{

  Future transactionCardCredit(PagarMeModel data) async {
    try {
      Dio? dio = CustomDio().instance;

      final response = await dio?.post(API_URL_PAGARME + "transactions",
        data: data,
        // options: Options(followRedirects: false, validateStatus: (status) { return status! < 500; })
      );

      if (response?.statusCode == 200) {
        print("aqui");

      } else {
        print("${response?.data}");

      }
    } catch (e) {
      print("${e}");

    }
  }
}
