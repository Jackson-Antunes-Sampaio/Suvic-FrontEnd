import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StockVacineRepository {
  final String service = 'clinics/storage/list';

  getAllVacine() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "cookie");

      print(token);

      // print('Tock:' + token!);
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + service);

      // print("aqui vacine");
      print("StatusCode: ${response.statusCode}");

      print("${response.data}");

      List<StockVacineModel> res = [];

      response.data.forEach((element) {
        // print(element);
        res.add(StockVacineModel(
            name: element['vaccine'].toString(),
            lote: int.parse(element['batch']),
            dataValidade: element['expirationdate'],
            quantidade: element['count'],
            valor: 0));
      });

      return res;
      //return StockVacineModel.fromJson(response.data);
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  insert(StockVacineModel stockvacine) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "cookie");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.post(API_URL + 'clinics/storage', data: {
        'batch': stockvacine.lote.toString(),
        'expirationdate': stockvacine.dataValidade,
        'count': stockvacine.quantidade,
        'reserved': 0,
        'vaccine': stockvacine.name
      });

      if (response.statusCode == 200) {
        print('OK');
      } else {
        print('Error code ${response.statusCode}');
      }
    } catch (e) {
      print('Error Insert $e');
    }
  }
}
