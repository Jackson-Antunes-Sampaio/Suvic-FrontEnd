import 'package:suvic_app/common/icon_button_custom.dart';
import 'package:suvic_app/controllers/notify_covid_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownCustom extends StatelessWidget {

  NotifyCovidController notifyCovidController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: notifyCovidController.selectUf.value,
        // onSaved: (text) {
        // print("aaa $text");
        //   return _value.value = text;
        // },
        validator: (select) {
          if (select == 'Estado') {
            return 'Escolha uma opção';
          } else {
            return null;
          }
        },
        builder: (state){
          return Column(
            children: [
              Row(
                children: [
                  IconButtonCustom(
                    iconData: Icons.map,
                    size: 35,
                    color: Colors.grey,
                  ),
                  Expanded(
                      child: Obx(() {
                        return Container(
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: state.hasError ? Colors.red : Colors.grey,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            //menuMaxHeight: 1000,
                            itemHeight: 50,
                            onChanged: (newValue) {
                              notifyCovidController.selectUf.value = newValue!;
                              state.setValue(newValue);
                            },
                            value: notifyCovidController.selectUf.value,
                            items:
                            notifyCovidController.stateUf.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    )
                ],
              ),
              if (state.hasError)
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only( left: 55, top: 5),
                  child: Text(
                    state.errorText!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
            ],
          );
        },
    );
  }
}
