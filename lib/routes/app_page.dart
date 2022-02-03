
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:suvic_app/screens/agendament/scheduling.dart';
import 'package:suvic_app/screens/apply_vaccine/apply_vaccine_screen.dart';
import 'package:suvic_app/screens/b2c_my_agendaments/b2c_my_agendaments_page.dart';
import 'package:suvic_app/screens/b2c_show_my_agendaments/b2c_show_my_agendaments_page.dart';
import 'package:suvic_app/screens/base/base_screen.dart';
import 'package:suvic_app/screens/credit_card/credit_card_screen.dart';
import 'package:suvic_app/screens/credit_card/credit_card_screen2.dart';
import 'package:suvic_app/screens/credit_card/product_card.dart';
import 'package:suvic_app/screens/historic_vaccine/historic_vaccine_screen.dart';
import 'package:suvic_app/screens/home/home_screen.dart';
import 'package:suvic_app/screens/info/info_screen.dart';
import 'package:suvic_app/screens/login/login_screen.dart';
import 'package:suvic_app/screens/login/singup_screen.dart';
import 'package:suvic_app/screens/not_connect/not_connect_screen.dart';
import 'package:suvic_app/screens/notify_covid/notify_covid_screen.dart';
import 'package:suvic_app/screens/old_vaccine_card/oldVaccineCard_screen.dart';
import 'package:suvic_app/screens/passaport/passaport.dart';
import 'package:suvic_app/screens/profile/profile_screen.dart';
import 'package:suvic_app/screens/register_applicator/registration_users_screen.dart';
import 'package:suvic_app/screens/splash/splash_screen.dart';
import 'package:suvic_app/screens/stock/stock_new.dart';
import 'package:suvic_app/screens/vaccine_card/vaccine_card_screen.dart';
import 'package:suvic_app/screens/webview_suvic/webView_faceBook.dart';
import 'package:suvic_app/screens/webview_suvic/webView_instragram.dart';
import 'package:suvic_app/screens/webview_suvic/webView_youTube.dart';
import 'package:suvic_app/screens/webview_suvic/webview_suvic_screen.dart';

part 'app_routes.dart';

class AppPage {
  static const INITIAL = Routes.SPLASHSCREENAPP;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      //binding: HomeBindings()
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
      //binding: HomeBindings()
    ),
    GetPage(
      name: Routes.SPLASHSCREENAPP,
      page: () => SplashScreenApp(),
    ),
    GetPage(
      name: Routes.INFO,
      page: () => InfoScreen(),
    ),
    GetPage(
      name: Routes.VACCINECARD,
      page: () => VaccineCardScreen(),
    ),
    GetPage(
      name: Routes.NOTIFYCOVID,
      page: () => NotifyCovidScreen(),
    ),
    GetPage(
      name: Routes.BASE,
      page: () => BaseScreen(),
    ),
    GetPage(
      name: Routes.SUVIC,
      page: () => WebViewSuvicScreen(),
    ),
    GetPage(
      name: Routes.REGISTRATIONUSERS,
      page: () => RegisterApplicator(),
    ),
    GetPage(
      name: Routes.StockVacina,
      page: () => Stock(),
    ),
    GetPage(
      name: Routes.AGENDAMENT,
      page: () => Agendament(),
    ),
    GetPage(name: Routes.CREDITCARDS, page: () => CreditCardScreen()),
    GetPage(name: Routes.CREDITCARDS2, page: () => CreditCardNewScreen()),
    GetPage(name: Routes.CONNECT, page: () => NotConnect()),
    GetPage(
      name: Routes.PRODUCTCARD,
      page: () => ProductCardScreen(),
    ),
    GetPage(
      name: Routes.APPLYVACCINE,
      page: () => ApplyVaccineScreen(),
    ),
    GetPage(
      name: Routes.HISTORICVACCINE,
      page: () => HistoricVaccineScreen(),
    ),
    GetPage(
      name: Routes.SINGUP,
      page: () => SingUp(),
    ),
    GetPage(
      name: Routes.AGENDAM,
      page: () => Agendament(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.OLDVACCINECARD,
      page: () => OldVaccineCardScreen(),
    ),
    GetPage(
      name: Routes.PASSAPORT,
      page: () => Passaport(),
    ),
    GetPage(
      name: Routes.FACEBOOK,
      page: () => WebViewSuvicFaceBook(),
    ),
    GetPage(
      name: Routes.INSTAGRAM,
      page: () => WebViewSuvicInstagram(),
    ),
    GetPage(
      name: Routes.YOUTUBE,
      page: () => WebViewSuvicYouTube(),
    ),
    GetPage(
      name: Routes.B2CMYAGENDAMENTPAGE,
      page: () => B2cMyAgendamentPage(),
      //binding: HomeBindings()
    ),
    GetPage(
      name: Routes.B2C_SHOW_MY_AGENDAMENTS_PAGE,
      page: () => B2cShowMyAgendamentsPage(),
      //binding: HomeBindings()
    ),
  ];
}
