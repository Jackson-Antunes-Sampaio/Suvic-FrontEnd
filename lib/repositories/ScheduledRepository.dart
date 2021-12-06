import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suvic_app/models/scheduledModel.dart';
import 'package:suvic_app/models/user_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class ScheduledRepository {
  Future<List<ScheduledModel>> getAllScheduled() async {
    // try {
    Dio? dio = CustomDio().instance;
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");

    dio!.options.headers["Cookie"] = token;
    final response = await dio.get(API_URL + 'clinics/schedule/list');

    List<ScheduledModel> scheduleds = [];

    if (response.data.isNotEmpty) {
      response.data.forEach((scheduled) {
        //format time
        String time = scheduled['time'].toString();
        var timeList = time.split('.');
        var part = '0';
        if (timeList.length > 1) {
          part = timeList[1];
        }
        var calMinutes = (double.parse(('0.' + part))) * 60;
        var minutes =
            calMinutes.toInt() == 0 ? '00' : calMinutes.toInt().toString();
        var timeS = timeList[0] + ':' + minutes;

        scheduleds.add(ScheduledModel(
          date: scheduled['date'] ?? '',
          updatedAt: scheduled['updatedAt'] ?? '',
          time: timeS,
          slot: scheduled['slot'],
          status: scheduled['status'],
          user: UserModel.fromJson(scheduled['user']),
        ));
      });
    }
    //print('O TIME ESTA RETORNANDO ====>${response.data['time'].toString()}');
    return scheduleds;
    // } catch (e) {
    //   print(e);
    //   Get.snackbar(
    //     'Erro',
    //     'Não possível obter os agendados',
    //     backgroundColor: Colors.red,
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   List<ScheduledModel> scheduleds = [];
    //   return scheduleds;
    // }
  }
}
