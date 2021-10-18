import 'dart:ui';

import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderContainerVacina extends StatelessWidget {
  var text = "Adicionar Vacina";

  HeaderContainerVacina(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 2,
              left: 116,
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          Center(
            child: Image.asset('assets/images/2vacine.png'),
          ),
        ],
      ),
    );
  }
}
