
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaccineRepository {

  final String service = 'vaccines/';

  Future<List<String>> getaAll() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();


      final token = await storage.read(key: "cookie");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + service);

      List<String> vacines = [];

      response.data.forEach((element) {
        vacines.add(element['name']);
      });

      return vacines;
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
