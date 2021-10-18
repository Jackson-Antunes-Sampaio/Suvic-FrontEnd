import 'package:suvic_app/controllers/StockController.dart';
import 'package:suvic_app/controllers/clinicController.dart';
import 'package:suvic_app/models/Clinic_model.dart';
import 'package:suvic_app/screens/agendament/autocomplete/aVaccinesAgend.dart';
import 'package:suvic_app/utils/styles/style.dart';
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
