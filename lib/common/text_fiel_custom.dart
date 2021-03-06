
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import 'icon_button_custom.dart';

class TextFieldCustom extends StatelessWidget {
  TextFieldCustom(
      {this.iconData,
      this.labelText,
      this.hintText,
      this.textInputType,
      this.validator,
      this.controller,
      this.textInputFormatter,
      this.onChanged,
      this.initialValue,
      this.enabled
      });

  final IconData? iconData;
  final String? labelText;
  final String? hintText;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onChanged;
  final String? initialValue;
  final enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      onChanged: onChanged ?? (text) {},
      inputFormatters: textInputFormatter ?? [],
      decoration: InputDecoration(
        enabled: enabled ?? true,
        isDense: true,
        prefixIcon: iconData == null
            ? null
            : IconButtonCustom(
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
