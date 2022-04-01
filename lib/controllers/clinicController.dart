import 'package:get/get.dart';
import 'package:suvic_app/models/Clinic_model.dart';
import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/models/user_model.dart';
import 'package:suvic_app/repositories/StockRepository.dart';
import 'package:suvic_app/repositories/clinicRepository.dart';
import 'package:suvic_app/repositories/user_repository.dart';

class ClinicController extends GetxController {
  ClinicController({this.idClinic});
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

  //vacine selected
  List<StockVacineModel> vaccineInStock = [];
  //seach
  bool seachStatus = false;

  //args
  String? idClinic;

  @override
  onInit() {
    getAllClinics();
    super.onInit();
  }

  changeSeachStatus() {
    if (seachStatus) {
      seachStatus = false;
    } else {
      seachStatus = true;
    }
    update();
  }

  getAllClinics() async {
    loading = true;
    var cli = idClinic ?? '';
    var clinicsList = await clinicRepository.getAllClinis();
    clinics.clear();
    clinicsList!.forEach((element) {
      if (cli == element.id.toString()) {
        clinic = element;
        print('Nome:' + clinic.name.toString());

        clinics.add(element);
      } else {
        clinics.add(element);
      }
    });
    loading = false;
    update();
  }
}
