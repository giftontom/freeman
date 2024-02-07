
import 'package:flutter/material.dart';
import 'package:freeman/src/Screens/cam_view.dart';
import 'package:freeman/src/Screens/home.dart';
import 'package:freeman/src/Screens/splash.dart';
import 'package:freeman/src/Screens/splash_video.dart';
import 'package:freeman/src/Screens/vegitables/vegitables.dart';
import 'package:freeman/src/Screens/vegitables/vegitableslist.dart';
import 'package:freeman/src/Screens/vr_view.dart';
import 'package:freeman/src/freeman.dart';

class Routes {

  static const String splash = '/splash';
  static const String splash1 = '/splash1';
  static const String home = '/home';
  static const String camView = '/camView';
  static const String vegDetails = '/vegDetails';
  static const String vegList = '/vegList';

  static final routes = {
    splash: (_) => SplashScreen(),
    splash1: (_) => SplahVideo(),
    home: (_) => HomePage(),
    camView: (_) => MonitoringPage(ipAddres: '',),
    vegDetails:(_) => GrowingDetailsScreen(),
    vegList:(_) => VegetableScreen()

  };

  
  static pushPage(Widget page) {
    Navigator.push(navigatorKey.currentState!.context,
        MaterialPageRoute(builder: (context) => page));
  }

  static pushNamed(String route, {arguments}) {
    if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name !=
        route) {
      Navigator.pushNamed(
        navigatorKey.currentState!.context,
        route,
        arguments: arguments,
      );
    }
  }

  static pushReplacementNamed(String route, {arguments}) {
    if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name !=
        route) {
      Navigator.pushReplacementNamed(
        navigatorKey.currentState!.context,
        route,
        arguments: arguments,
      );
    }
  }

  static dynamic goBack({dynamic result}) {
    return Navigator.maybePop(navigatorKey.currentState!.context, result);
  }

  static goToHome() {
    if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name !=
        home) { 
      Navigator.pushNamed(
        navigatorKey.currentState!.context,
        home,
      );
    }
  }

  static void pushNamedAndRemoveUntil(String route) {
    if (ModalRoute.of(navigatorKey.currentState!.context)?.settings.name !=
        route) {
      Navigator.of(navigatorKey.currentState!.context)
          .pushNamedAndRemoveUntil(route, (route) => false);
    }
  }
}
