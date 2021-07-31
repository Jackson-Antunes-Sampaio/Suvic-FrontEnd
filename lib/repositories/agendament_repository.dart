import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:dio/dio.dart';

class AgendamentRepository {
  final String service = '/agendament';
  Future<List<AgendamentModel>> getAll() async {
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

  insert(AgendamentModel agendamentModel) async {
    try {
      Dio dio = Dio();
      final response =
          await dio.post(API_URL + service, data: agendamentModel.toJson());

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
