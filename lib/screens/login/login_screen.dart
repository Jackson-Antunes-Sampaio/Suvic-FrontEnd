import 'package:connectivity/connectivity.dart';
import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/controllers/user_controller.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:suvic_app/screens/login/components/input_text_field.dart';
import 'package:suvic_app/screens/login/components/label_text.dart';
import 'package:suvic_app/screens/login/components/login_social_media.dart';
import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'components/input_text_field.dart';
import 'components/label_text.dart';
import 'components/login_social_media.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final UserController userController = Get.put(UserController());
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff3f51b5),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyHeader(
              image: "assets/images/gbimage.png",
              textTop: "              Login",
              textBottom: "",
              offset: offset,
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
                    controller: email,
                    textInputType: TextInputType.emailAddress,
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
                    controller: pass,
                    hintText: "*******",
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        final snackBar = SnackBar(
                          content: Text('Em manutenção'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text(
                        'Esqueceu sua Senha?',
                        style: TextStyle(color: Colors.blue[900]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx(() {
                    return Align(
                      alignment: Alignment.center,
                      child: !userController.loading.value
                          ? Container(
                              height: 46,
                              width: 160,
                              child: RaisedButton(
                                onPressed: () async {
                                  var connectivityResult = await (Connectivity()
                                      .checkConnectivity());

                                  if (connectivityResult ==
                                      ConnectivityResult.none) {
                                    Get.snackbar("Conexão",
                                        "Sem conexão com a internet");
                                  } else {
                                    final String response = await userController
                                        .loginIn(email.text, pass.text);
                                    if (response == "Usuario Logado!") {
                                      Get.offNamed(Routes.BASE);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text('$response'),
                                        backgroundColor: Colors.red,
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
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
                            )
                          : CircularProgressIndicator(),
                    );
                  }),
                  SizedBox(
                    height: 12,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Ou",
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w700,
                  //       color: Colors.black54,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 18,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     InkWell(
                  //       child: LoginSocialMediaBtn(
                  //           icon: FontAwesomeIcons.facebookF,
                  //           color: facebookColor,
                  //           onPress: () {
                  //             Get.toNamed(Routes.FACEBOOK);
                  //           }),
                  //     ),
                  //     SizedBox(
                  //       width: 16,
                  //     ),
                  //     InkWell(
                  //       child: LoginSocialMediaBtn(
                  //         onPress: () {
                  //           Get.toNamed(Routes.INSTAGRAM);
                  //         },
                  //         icon: FontAwesomeIcons.instagram,
                  //         color: instagramColor,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 16,
                  //     ),
                  //     InkWell(
                  //
                  //       child: LoginSocialMediaBtn(
                  //         onPress: () {
                  //          Get.toNamed(Routes.YOUTUBE);
                  //          },
                  //         icon: FontAwesomeIcons.youtube,
                  //         color: youTubeColor,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 18,
                  ),
                  InkWell(
                    onTap: () {
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
