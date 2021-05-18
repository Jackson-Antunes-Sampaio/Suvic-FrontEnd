import 'package:flutter/material.dart';

Widget autocompleTime() {
  const List<String> _options = <String>[
    '09:30',
    '10:30',
    '11:30',
    '12:30',
    '13:30',
    '14:30',
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
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Horário',
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
                    leading: Icon(Icons.timer),
                    title: Text(option),
                    trailing: Text('$index/5'),
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
