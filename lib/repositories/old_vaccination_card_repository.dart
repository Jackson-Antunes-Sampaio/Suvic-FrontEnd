
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:suvic_app/models/passaport_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class OldVaccinationCardRepository {
  getCard() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users/images/paperCard");
      print('MENSAGEM DE RETORNO AO CAPTURAR IMAGEM ====> ${response.data}');
      return response.data;
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future insert(PassaportModel passpaort) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      Map<String, dynamic> map = {
        "paperCard": passpaort.documentFront!,
      };

      final response = await dio.post(API_URL + "users/images", data: map);
      print('MENSAGEM DE RETORNO AO ENVIAR IMAGEM ====> ${response.data['message']}');
      return response.data['message'];
    } catch (e) {
      print(e);
      return Future.error("Não foi possível realizar está operação!");
    }
  }
}
