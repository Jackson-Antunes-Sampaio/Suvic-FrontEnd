import 'package:connectivity/connectivity.dart';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'components/input_text_field.dart';
import 'components/label_text.dart';
import 'components/login_social_media.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff3f51b5),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyHeader(
              image: "assets/images/gbimage.png",
              textTop: "              Login",
              textBottom: "",
              offset: 0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: labelText('E-mail:'),
                  ),
                  InputTextField(
                    hintText: "exemplo@email.com",
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: labelText('Senha:'),
                  ),
                  InputTextField(
                    hintText: "*******",
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        'Esqueceu sua Senha?',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 46,
                      width: 160,
                      child: RaisedButton(
                        onPressed: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());

                          if (connectivityResult == ConnectivityResult.none) {
                            Get.snackbar(
                                "Conexão", "Sem conexão com a internet");
                          } else {
                            final String response = await userController
                                .loginIn("jackson@email.com", "jackson");
                            if (response == "Usuario Logado!") {
                              Get.offNamed(Routes.BASE);
                            } else {
                              Get.snackbar(
                                "Falha ao Entrar",
                                "$response",
                              );
                              final snackBar = SnackBar(
                                content: Text('$response'),
                                backgroundColor: Colors.red,
                                // action: SnackBarAction(
                                //   label: 'Undo',
                                //   onPressed: () {
                                //     // Some code to undo the change.
                                //   },
                                // ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }

                          // final response2 = await  dio.post(
                          //   "https://ec2-18-231-166-223.sa-east-1.compute.amazonaws.com:8443/login/",
                          //   data: {
                          //     "email" : "jack@user.com",
                          //     "password" : "123456",
                          //   }
                          // );
                          // print("aqui ${response2.data}");
                        },
                        child: Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 16),
                        ),
                        color: Color(0xff303f9f),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ou",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoginSocialMediaBtn(
                        icon: FontAwesomeIcons.facebookF,
                        color: facebookColor,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      LoginSocialMediaBtn(
                        icon: FontAwesomeIcons.google,
                        color: googleColor,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      LoginSocialMediaBtn(
                        icon: FontAwesomeIcons.twitter,
                        color: twitterColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.SINGUP);
                    },
                    child: Container(
                      color: Colors.grey[50],
                      padding: EdgeInsets.only(bottom: 16),
                      height: 60,
                      child: Center(
                        child: Text(
                          'Não tem conta? Cadastre-se agora',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: facebookColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
