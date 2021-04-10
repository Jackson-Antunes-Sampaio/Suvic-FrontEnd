import 'package:covid_19/common/icon_button_custom.dart';
import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {

  TextFieldCustom({this.iconData, this.labelText, this.hintText, this.textInputType});

  final IconData iconData;
  final String labelText;
  final String hintText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonCustom(
          iconData: iconData,
          color: Colors.grey,
          size: 35,
        ),
        Expanded(
          child: TextFormField(
            validator: (text){
              if(text.isEmpty){
                return 'Campo Vazio';
              }else{
                return null;
              }
            },
              keyboardType: textInputType,
              decoration: InputDecoration(
            isDense: true,
            labelText: labelText,
            hintText: hintText,
            //enabledBorder: InputBorder.none,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          )),
        )
      ],
    );
  }
}
