import 'package:covid_19/screens/credit_card/components/text_form_field.dart';
import 'package:flutter/material.dart';

Widget autocompleVaccine() {
  const List<String> _options = <String>[
    'Vaccine 1',
    'Vaccine 2',
    'Vaccine 3',
    'Vaccine 4',
    'Vaccine 5',
    'Vaccine 6',
    'Vaccine 7',
  ];
  return RawAutocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      return _options.where((String option) {
        return option.contains(textEditingValue.text.toLowerCase());
      });
    },
    fieldViewBuilder: (BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted) {

      // return TextFormFieldCustom(
      //     controller: textEditingController,
      //     keyboardType: TextInputType.text,
      //     inputFormatters: [],
      //     labelText: 'Vacina',
      //     hintText: 'Vacina',
      //     validator: (value){},
      //     //keyboardType: keyboardType,
      //     onChanget: (value){});
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Vacina',
          isDense: true,
          border: OutlineInputBorder(),
        ),
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      );
    },
    optionsViewBuilder: (BuildContext context,
        AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
      return Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4.0,
          child: SizedBox(
            height: 200.0,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final String option = options.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    onSelected(option);
                  },
                  child: ListTile(
                    leading: Image.asset(
                      'assets/images/iconVacine.png',
                      width: 30,
                      height: 30,
                    ),
                    title: Text(option),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
