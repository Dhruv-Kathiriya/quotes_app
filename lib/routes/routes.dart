import 'package:flutter/cupertino.dart';
import 'package:qoutesapp/view/screens/detalispage/details.dart';
import 'package:qoutesapp/view/screens/homepage/home.dart';

import '../view/screens/splashscreen/spalsh.dart';

class Routes {
  static String splashscreen = "/";
  static String homepage = "home_page";
  static String detailspage = "details_page";

  static Map<String, WidgetBuilder> myRoutes = {
    splashscreen: (context) => const Spalshscreen(),
    homepage: (context) => const HomePage(),
    detailspage: (context) => const DetailsPage(),
  };
}
