import 'package:covid_19/models/scheduledModel.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ScheduledRepository {
  Future<List<ScheduledModel>> getAllScheduled() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + 'clinics/schedule/list');

      List<ScheduledModel> scheduleds = [];

      if (response.data.isNotEmpty) {
        response.data.forEach((scheduled) {
          scheduleds.add(ScheduledModel(
            date: scheduled['date'] ?? '',
            updatedAt: scheduled['updatedAt'] ?? '',
            slot: scheduled['slot'],
            status: scheduled['status'],
            user: UserModel.fromJson(scheduled['user']),
          ));
        });
      }
      return scheduleds;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não possível obter os agendados',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      List<ScheduledModel> scheduleds = [];
      return scheduleds;
    }
  }
}
