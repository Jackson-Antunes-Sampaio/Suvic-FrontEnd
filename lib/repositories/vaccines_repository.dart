import 'package:covid_19/models/vaccine_model.dart';
import 'package:covid_19/models/vacine_card_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaccineRepository {
  final String service = 'vaccines/';

  Future<VaccineModel> vaccines() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "cookie");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + service);

      if (response.statusCode == 200) {
        return VaccineModel.fromJson(response.data);
      } else {
        return VaccineModel();
      }
    } catch (e) {
      print(e);
      return Future.error("error");
    }
    // try {
    //   Dio dio = CustomDio().instance!;

    //   final response = await dio.post(API_URL + "vaccines");

    //   if (response.statusCode == 201) {
    //     return VaccineModel.fromJson(response.data["name"]);
    //   } else {}
    // } catch (e) {}
  }

  // Future<VaccineCardModel> vaccineCard(int id, String batch, String applicationDate) async {
  //   try {
  //     Dio dio = CustomDio().instance!;
  //
  //     final response = await dio.post(API_URL + "vaccinecard", data: {
  //       "id": id,
  //       "batch": batch,
  //       "applicationDate": applicationDate
  //     });
  //
  //     if (response.statusCode == 201) {
  //       return VaccineCardModel.fromJson(response.data);
  //     } else {}
  //   } catch (e) {}
  // }

}
