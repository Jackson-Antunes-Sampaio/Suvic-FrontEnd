import 'package:covid_19/common/icon_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {this.iconData, this.labelText, this.hintText, this.textInputType, this.validator, this.controller, this.textInputFormatter, this.onChanged});

  final IconData? iconData;
  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              controller: controller,
              validator: validator,
              keyboardType: textInputType,
              onChanged: onChanged ?? (text){},
              inputFormatters: textInputFormatter ?? [],
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: IconButtonCustom(
                  iconData: iconData,
                  color: Colors.grey,
                  size: 35,
                ),
                labelText: labelText,
                hintText: hintText,
                //enabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
          );
  }
}
