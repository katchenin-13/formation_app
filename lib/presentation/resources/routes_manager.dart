import 'package:flutter/material.dart';
import 'package:formation_app/app/di.dart';
import 'package:formation_app/presentation/forgot_password/forgot_password.dart';
import 'package:formation_app/presentation/login/login_view.dart';
import 'package:formation_app/presentation/main/main.dart';
import 'package:formation_app/presentation/onBoarding/onboarding.dart';
import 'package:formation_app/presentation/register/register.dart';
import 'package:formation_app/presentation/resources/strings_manager.dart';
import 'package:formation_app/presentation/splash/splash.dart';

class Routes {

  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register'; 
static const String forgotPasswordRoute = "/forgotPassword";  static const String mainRoute = '/main';
  static const String storeDetailsRoute ='/storeDetails';
  
}

class  RoutesGenerator{

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {

      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.forgotPasswordRoute:
         initForgotPasswordModule();
         return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
         return MaterialPageRoute(builder:(_)=>const MainView());
      case Routes.registerRoute:
         initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView()); 
      default:
      return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(
       builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound)
        ),

        body: const Center(child: Text(AppStrings.noRouteFound ,),

      ),
       ),
    );
  }
}