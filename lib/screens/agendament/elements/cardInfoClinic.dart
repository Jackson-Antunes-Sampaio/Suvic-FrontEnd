import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/screens/agendament/autocomplete/aVaccinesAgend.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/state_manager.dart';

Card showCardBtnClose(ClinicModel clinic, ClinicController controller) {
  return Card(
    margin: EdgeInsets.all(0),
    child: Container(
      color: kPrimaryColor,
      child: Container(
        width: double.maxFinite,
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: FaIcon(FontAwesomeIcons.hospitalSymbol),
          ),
          title: Text(
            clinic.name!,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            clinic.address!,
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            onPressed: () => StockController.to
                .removeVacineInCart(StockController.to.vacineSelected.first),
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

Card showCompanyNameCard(ClinicModel clinic, ClinicController controller) {
  return Card(
    margin: EdgeInsets.all(0),
    child: Container(
      color: kPrimaryColor,
      child: Container(
        width: double.maxFinite,
        height: 70,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: FaIcon(FontAwesomeIcons.hospitalSymbol),
          ),
          title: Text(
            clinic.name!,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            clinic.address!,
            style: TextStyle(color: Colors.white),
          ),
          trailing: GetBuilder<StockController>(builder: (cst) {
            return cst.vacineSelected.isEmpty
                ? IconButton(
                    onPressed: () => controller.changeSeachStatus(),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                : Text('');
          }),
        ),
      ),
    ),
  );
}

Card seachCard(BuildContext context, ClinicController controller) {
  return Card(
    margin: EdgeInsets.all(0),
    child: Container(
      color: kPrimaryColor,
      child: Container(
        width: double.maxFinite,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: ListTile(
            title: Container(
              width: double.maxFinite,
              child: autocompleVaccinesAgendaments(
                context,
                controller,
              ),
            ),
            trailing: IconButton(
              onPressed: () => controller.changeSeachStatus(),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
