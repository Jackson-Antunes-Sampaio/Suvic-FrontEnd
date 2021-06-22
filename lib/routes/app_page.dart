import 'package:covid_19/screens/agendament/agendament.dart';
import 'package:covid_19/screens/base/base_screen.dart';
import 'package:covid_19/screens/credit_card/credit_card_screen.dart';
import 'package:covid_19/screens/home/home_screen.dart';
import 'package:covid_19/screens/info/info_screen.dart';
import 'package:covid_19/screens/login/login_screen.dart';
import 'package:covid_19/screens/notify_covid/notify_covid_screen.dart';
import 'package:covid_19/screens/registration_users/registration_users_screen.dart';
import 'package:covid_19/screens/splash/splash_screen.dart';
import 'package:covid_19/screens/stock/dashboard.dart';
import 'package:covid_19/screens/vaccine_card/vaccine_card_screen.dart';
import 'package:covid_19/screens/webview_suvic/webview_suvic_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
      page: () => RegistrationUsersScreen(),
    ),
    GetPage(
      name: Routes.StockVacina,
      page: () => DashboardStock(),
    ),
    GetPage(
      name: Routes.AGENDAMENT,
      page: () => Agendament(),
    ),
    GetPage(name: Routes.CREDITCARDS, page: () => CreditCardScreen())
  ];
}
