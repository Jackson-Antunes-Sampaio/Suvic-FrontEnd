import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/StockRepository.dart';
import 'package:covid_19/repositories/clinicRepository.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  //Get User Repository
  final UserRepository userRepository = UserRepository();
  var repository = StockRepository();
  bool loading = false;

  var userOn = UserModel().obs;
  //Clinic Repository
  var clinicRepository = ClinicRepository();
  var clinicAdress = ''.obs;
  var clinic = ClinicModel();
  List<ClinicModel> clinics = [];
  //Get Instance
  static ClinicController get to => Get.find();
  //vacine selected
  List<StockVacineModel> vaccineInStock = [];
  //seach
  bool seachStatus = false;

  //args
  String? idClinic;

  ClinicController({this.idClinic}) {
    // getClinicAdress();
    getAllClinics();
    // var cli = idClinic ?? '';
    // if (cli.isNotEmpty) {
    //   print('Entro');
    //   getVaccinesInStock();
    // }
  }

  changeSeachStatus() {
    if (seachStatus) {
      seachStatus = false;
    } else {
      seachStatus = true;
    }
    update();
  }

  // getVaccinesInStock() async {
  //   loading = true;
  //   var getvaccinesStock =
  //       await repository.getStockVaccineByIdClinic(idClinic!);

  //   if (getvaccinesStock != null) {
  //     vaccineInStock.clear();
  //     getvaccinesStock.forEach((vaccine) {
  //       var name;
  //       if (vaccine['vaccineName'] == null) {
  //         name = '';
  //       } else {
  //         name = vaccine['vaccineName'];
  //       }
  //       vaccineInStock.add(
  //         StockVacineModel(
  //           name: name,
  //           lote: vaccine['batch'] == null ? '' : vaccine['batch'],
  //           dataValidade: vaccine['expirationdate'] == null
  //               ? ''
  //               : vaccine['expirationdate'],
  //           quantidade: vaccine['count'],
  //         ),
  //       );
  //     });
  //     loading = false;
  //     print('Update:' + vaccineInStock.toString());
  //     update();
  //   }
  // }

  getAllClinics() async {
    loading = true;
    //get id Clinic
    var cli = idClinic ?? '';
    var clinicsList = await clinicRepository.getAllClinis();
    clinics.clear();
    clinicsList!.forEach((element) {
      if (cli == element.id.toString()) {
        clinic = element;
        clinics.add(element);
      } else {
        clinics.add(element);
      }
    });
    loading = false;
    update();
  }
}
