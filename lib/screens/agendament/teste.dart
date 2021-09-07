import 'package:covid_19/controllers/home_controller.dart';
import 'package:covid_19/controllers/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<TimeSlotController>(
              init: TimeSlotController(idClinic: '2'),
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => controller.selectDate(context),
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController()
                            ..text = controller.showDate ?? '',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
