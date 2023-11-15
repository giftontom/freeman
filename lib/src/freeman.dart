import 'package:freeman/src/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



class FreemanApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: "Saas",
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      navigatorKey: navigatorKey,
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
    );
  }
}
