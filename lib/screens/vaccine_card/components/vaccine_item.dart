import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaccineItem extends StatelessWidget {

  VaccineItem(
      {@required this.index,
      @required this.vaccines,
      });

  final int index;
  final List<String> vaccines;
  Rx<Color> color = Colors.white.obs;

  final Color colorTile = Colors.white;
  final Color colorText = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Obx(
        (){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                color.value = Colors.blueAccent;
              },
              onLongPress: (){
                color.value = Colors.white;
              },
              child: Container(
                decoration: BoxDecoration(
                    color: color.value,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Center(
                  child: Text(
                    "${vaccines[index]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorText,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
