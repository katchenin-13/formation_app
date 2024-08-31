import 'package:formation_app/presentation/resources/language_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';
 const String PREFS_KEY_LANG ="PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";

class AppPreferences{
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async{
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language!= null && language.isNotEmpty ){
      return language;
    }
    else{
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void>setOnBoardingScreenView() async{
     _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }
  Future<bool>isOnBoardingScreenView() async{
   return  _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void>setIsUserLoggedIn() async{
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool>IsUserLoggedIn()async{
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}