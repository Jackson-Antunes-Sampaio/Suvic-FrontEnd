import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:dio/dio.dart';

class StockVacineRepository {
  final String service = '/stockVacine';
  Future<List<StockVacineModel>> getAll() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(API_URL + service);

      if (response.statusCode == 200) {
        print('OK');
      } else {
        print('Error');
      }
      return response.data;
    } catch (e) {
      print('Error in get all Vaccines');
      return [];
    }
  }

  insert(StockVacineModel stockvacine) async {
    try {
      Dio dio = Dio();
      final response =
          await dio.post(API_URL + service, data: stockvacine.toJson());

      if (response.statusCode == 200) {
        print('OK');
      } else {
        print('Error');
      }
    } catch (e) {
      print('Error Insert');
    }
  }
}
