import 'package:flutter/material.dart';

class VaccineItem extends StatelessWidget {
  VaccineItem({this.title, this.quantity, this.date, this.desc, this.local, this.city});

  final String title;
  final String quantity;
  final String date;
  final String desc;
  final String local;
  final String city;

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
                    Text("Local:"),
                    Text("$local"),
                  ],
                ),
                Divider(),
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
