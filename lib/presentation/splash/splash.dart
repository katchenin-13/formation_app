import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formation_app/app/app_prefs.dart';
import 'package:formation_app/app/di.dart';
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
  AppPreferences _appPreferences = instance<AppPreferences>();

  _starDelay() {
    _timer = Timer(Duration(seconds: 2), _geNext);
  }

  _geNext() async {
    _appPreferences.IsUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              //navigator to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenView()
                  .then((isOnBoardingScreenView) => {
                        if (isOnBoardingScreenView)
                          {
                            //Navigate to login
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      }
                      )
            }
        }
        );
  }

  @override
  void initState() {
    super.initState();
    _starDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(
              image: AssetImage(
        ImageAssets.splashLogo,
      ))),
    );
  }
}
