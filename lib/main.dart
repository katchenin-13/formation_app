import 'package:flutter/material.dart';
import 'package:formation_app/app/app.dart';
import 'package:formation_app/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule(); // Configurez les dépendances
  runApp(MyApp()   
    
  );
}

