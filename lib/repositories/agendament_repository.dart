import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AgendamentRepository {
  final String service = '/clinics/schedule';
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
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "cookie");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.post(API_URL + service, data: {
        'start': agendamentModel.data,
        'end': agendamentModel.time,
        'title': agendamentModel.vaccine,
        'clinic': ClinicController.to.clinic.value.id!,
      });

      if (response.statusCode == 200) {
        print('OK');
      } else {
        print('Error');
      }
    } catch (e) {
      print(e);
      print('Error Insert');
    }
  }
}
