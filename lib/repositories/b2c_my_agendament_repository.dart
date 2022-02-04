

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suvic_app/models/b2c_my_agendament_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';


class B2cMyAgendamentRepository {
  Future<Object> getVaccineCard() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
       print('TOKEN===>$token');
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users/vaccinecard");
      print("VACINAS AGENDADAS===>$response");
      return (response.data as List).map<B2cMyAgendamentModel>((e) {
        return B2cMyAgendamentModel.fromJson(e);
      }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }


}

