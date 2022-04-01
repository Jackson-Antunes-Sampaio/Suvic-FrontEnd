import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class StockVacineRepository {
  final String service = 'clinics/storage/list';

  Future<List<StockVacineModel>> getAllVacine() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + service);
      var vacines;
      response.data.forEach((element) {
        vacines.add(StockVacineModel.fromJson(element));
      });
      return vacines;
    } catch (e) {
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
