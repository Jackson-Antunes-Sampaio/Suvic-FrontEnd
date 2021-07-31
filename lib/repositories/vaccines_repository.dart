
import 'package:covid_19/models/vacine_card_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaccineRepository {

  Future<List<VaccineCardModel>> getVaccineCard()async{

    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users/vaccinecard");

      return (response.data as List).map<VaccineCardModel>((e) {
       return VaccineCardModel.fromJson(e);
      }).toList();
    }catch(e){
      print(e);
      return Future.error("error");
    }
  }

}
