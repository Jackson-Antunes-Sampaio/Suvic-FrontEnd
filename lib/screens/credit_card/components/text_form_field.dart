import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldCustom extends StatelessWidget {
  TextFormFieldCustom({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.validator,
    required this.inputFormatters,
    required this.keyboardType,
    required this.onChanget,
    this.maxLength
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final String hintText;
  final String labelText;
  final Function(String) onChanget;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanget,
        maxLength: maxLength ?? 50,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          counterText: '',
          hintText: hintText,
          labelText: labelText,
          isDense: true,
        ),
      ),
    );
  }
}
