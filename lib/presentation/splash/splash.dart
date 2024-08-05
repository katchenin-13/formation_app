import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formation_app/presentation/resources/assets_manager.dart';
import 'package:formation_app/presentation/resources/color_managrer.dart';
import 'package:formation_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _starDelay(){
    _timer = Timer(Duration(seconds: 2), _geNext);
  }

  _geNext(){
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
 void initState(){
  super.initState();
  _starDelay();
 }

 @override
 void dispose(){
  _timer?.cancel();
  super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagrer.primary,
      body: const Center(
        child: Image(image:AssetImage(ImageAssets.splashLogo,))
      ),
    );
  }
}