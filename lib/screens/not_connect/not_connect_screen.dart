import 'package:connectivity/connectivity.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotConnect extends StatelessWidget {
  final UserController userController = Get.find();
  RxBool _loading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 100,
            ),
            Text(
              "Sem conexão com a internet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Color(0xff303f9f),
                textColor: Colors.white,
                onPressed: _loading.value ? null : () async {
                  _loading.value = true;
                  var connectivityResult = await (Connectivity().checkConnectivity());

                  if (connectivityResult == ConnectivityResult.none) {
                    _loading.value = false;

                  } else {
                    await userController.loginDate();

                    if (userController.user?.email != null) {
                      _loading.value = false;
                      Get.offNamed(Routes.BASE);
                    } else {
                      _loading.value = false;
                      Get.offNamed(Routes.LOGIN);
                    }
                  }
                },
                child: _loading.value ? Padding(padding: EdgeInsets.all(10), child: CircularProgressIndicator(),) : Text("Tentar novamente"),
              );
            })
          ],
        ),
      ),
    );
  }
}
