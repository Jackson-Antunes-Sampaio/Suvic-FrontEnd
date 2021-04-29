

import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/login/componets/input_text_field.dart';
import 'package:covid_19/screens/login/componets/label_text.dart';
import 'package:covid_19/screens/login/componets/login_social_media.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
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
                        onPressed: () async{
                          final UserController userController = UserController();
                          await userController.loginIn("jack@user.com", "123456789");

                          //Get.toNamed(Routes.BASE);
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
                          color: Colors.black54,),
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
                      SizedBox(width: 16,),
                      LoginSocialMediaBtn(
                        icon: FontAwesomeIcons.google,
                        color: googleColor,
                      ),
                      SizedBox(width: 16,),
                      LoginSocialMediaBtn(
                        icon: FontAwesomeIcons.twitter,
                        color: twitterColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
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
