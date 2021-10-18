import 'package:suvic_app/common/icon_button_custom.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.person_pin, color: Colors.grey.shade700, size: 100,),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: IconButtonCustom(
                onTap: (){
                  final snackBar = SnackBar(
                    content: Text('Em manutenção'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                iconData: Icons.add_a_photo,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
