
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suvic_app/models/historic_vaccine_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class HistoricVaccineRepository {

  Future<List<HistoricVaccineModel>> getHistoricVaccine()async{

    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "clinics/vaccinecards");

      return (response.data as List).map<HistoricVaccineModel>((e) {
        return HistoricVaccineModel.fromJson(e);
      }).toList();
    }catch(e){
      print(e);
      return Future.error("error");
    }
  }

}