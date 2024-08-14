import 'package:flutter/material.dart';
import 'package:formation_app/presentation/resources/routes_manager.dart';
import 'package:formation_app/presentation/resources/theme_manager.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
class MyApp extends StatefulWidget {
 MyApp._internal();
 static final MyApp instance = MyApp._internal();
 factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme :getApplicationTheme()
    );
  }
}