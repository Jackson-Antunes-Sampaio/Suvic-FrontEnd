import 'package:flutter/material.dart';

class VaccineItem extends StatelessWidget {
  VaccineItem({this.title, this.quantity, this.date, this.desc, this.status, this.city});

  final String? title;
  final String? quantity;
  final String? date;
  final String? desc;
  final String? status;
  final String? city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Column(
              children: [
                Text(
                  "$title",
                  style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Data Vacina:"),
                              Text("$date"),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status:"),
                              Text("$status"),
                            ],
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Image.asset("assets/images/qrcode_suvic.png", height: 60, width: 60,)
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text("$quantity"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
