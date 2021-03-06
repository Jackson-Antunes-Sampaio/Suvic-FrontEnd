import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class HeaderMenu extends StatefulWidget {
  final String? image;
  final String? email;
  final double? offset;

  const HeaderMenu({Key? key, this.image, this.email, this.offset})
      : super(key: key);

  @override
  _HeaderMenuState createState() => _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            padding: EdgeInsets.only(left: 40, top: 50, right: 20),
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF3383CD),
                  Color(0xFF11249F),
                ],
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/virus.png"),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -3,
          right: 0,
          left: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(
                              widget.image!,
                      )
                    ),
                  //     border: Border.all(
                  //   color: Colors.grey,
                  //       width: 3
                  // )
                  ),

        ),

              Container(
                //width: MediaQuery.of(context).size.width,
                child: Text(
                  "${widget.email}",
                  style: kHeadingTextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () {},
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: Text(
              //       "Sair",
              //       style: TextStyle(
              //         color: Colors.blue,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
