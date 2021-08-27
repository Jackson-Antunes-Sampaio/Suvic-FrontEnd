import 'package:covid_19/controllers/agendamentController.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DuaAgendament extends StatefulWidget {
  const DuaAgendament({Key? key}) : super(key: key);

  @override
  _DuaAgendamentState createState() => _DuaAgendamentState();
}

class _DuaAgendamentState extends State<DuaAgendament> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(icon: Icon(Icons.map)),
            Tab(icon: Icon(Icons.list)),
          ]),
        ),
        body: TabBarView(
          children: [
            mapClinics(),
            listClinics(),
          ],
        ),
      ),
    );
  }

  Widget listClinics() {
    return Center(
      child: Text('data'),
    );
  }

  Widget mapClinics() {
    return Center(
      child: Text('data'),
    );
  }
}
