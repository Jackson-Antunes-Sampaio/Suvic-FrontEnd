

import 'package:suvic_app/models/b2c_my_agendament_model.dart';

class B2cMyAgendamentRepository {
  Future<List<B2cMyAgendamentModelModel>> getVaccineCard() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users/vaccinecard");
      print("VACINAS AGENDADAS===>$response");
      return (response.data as List).map<VaccineCardModel>((e) {
        return VaccineCardModel.fromJson(e);
      }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }


}

