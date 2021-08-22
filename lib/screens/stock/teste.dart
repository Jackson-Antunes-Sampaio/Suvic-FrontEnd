main(List<String> args) {
  List list = [1, 3, 2, 4, 6, 5, 8, 7, 9];
  list.sort((a, b) => b.compareTo(a));
  print(list);
}
// import 'package:flutter/material.dart';

// class TesteViewStock extends StatefulWidget {
//   const TesteViewStock({Key? key}) : super(key: key);

//   @override
//   _TesteViewStockState createState() => _TesteViewStockState();
// }

// class _TesteViewStockState extends State<TesteViewStock> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//             ExpansionTile(leading: Icon(Icons.sailing), title: Text('data')),
//           ],
//         ),
//       ),
//     );
//   }
// }
