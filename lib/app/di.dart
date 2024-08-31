import 'package:formation_app/data/data_source/remote_data_source.dart';
import 'package:formation_app/data/network/app_api.dart';
import 'package:formation_app/data/network/dio_factory.dart';
import 'package:formation_app/data/network/network_info.dart';
import 'package:formation_app/data/repository_impl/repository_impl.dart';
import 'package:formation_app/domain/repository/repository.dart';
import 'package:formation_app/domain/usecase/forgot_password_usecase.dart';
import 'package:formation_app/domain/usecase/login_usecase.dart';
import 'package:formation_app/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:formation_app/presentation/login/login_viewmodel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  // network info implementation
  instance.registerLazySingleton<NetworkInfoImpl>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  // // local data source
  
  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  // //repository impl
  // instance.registerLazySingleton<RepositoryImpl>(
  //     () => RepositoryImpl(instance(), instance()));
}



initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

// initRegisterModule() {
//   if (!GetIt.I.isRegistered<RegisterUseCase>()) {
//     instance
//         .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
//     instance.registerFactory<RegisterViewModel>(
//         () => RegisterViewModel(instance()));
//     instance.registerFactory<ImagePicker>(() => ImagePicker());
//   }
// }

// initHomeModule() {
//   if (!GetIt.I.isRegistered<HomeUseCase>()) {
//     instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
//     instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
//   }
// }

// initStoreDetailsModule() {
//   if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
//     instance.registerFactory<StoreDetailsUseCase>(
//         () => StoreDetailsUseCase(instance()));
//     instance.registerFactory<StoreDetailsViewModel>(
//         () => StoreDetailsViewModel(instance()));
//   }
// }
