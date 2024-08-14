import 'package:flutter/material.dart';
import 'package:formation_app/app/di.dart';
import 'package:formation_app/presentation/login/login_viewmodel.dart';
import 'package:formation_app/presentation/resources/assets_manager.dart';
import 'package:formation_app/presentation/resources/color_managrer.dart';
import 'package:formation_app/presentation/resources/routes_manager.dart';
import 'package:formation_app/presentation/resources/strings_manager.dart';
import 'package:formation_app/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = instance<LoginViewModel>();
 // AppPreferences _appPreferences = instance<AppPreferences>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  _bind() {
    _viewModel.start();

    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManagrer.white,
      body: Container(
           padding: const EdgeInsets.only(top: AppPadding.p100),
           color: ColorManagrer.white,
           child: SingleChildScrollView(
             child: Form(
               key: _formKey,
               child: Column(
                 children: [
                      Image(image: AssetImage(ImageAssets.splashLogo)),
                   const SizedBox(
                     height: AppSize.s28,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(
                       left: AppPadding.p28,
                       right: AppPadding.p28,
                     ),
                     child: StreamBuilder<bool>(
                       stream: _viewModel.outputIsUserNameValid,
                       builder: (context, snapshot) => TextFormField(
                         keyboardType: TextInputType.emailAddress,
                         controller: _userNameController,
                         decoration: InputDecoration(
                           hintText: AppStrings.username,
                           labelText: AppStrings.username,
                           errorText: (snapshot.data ?? true)
                               ? null
                               : AppStrings.usernameError,
                         ),
                       ),
                     ),
                   ),

                    const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot) => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSize.s28,),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppPadding.p28,
                    right: AppPadding.p28,
                  ),
                  child: StreamBuilder<bool>(
                        stream: _viewModel.outputIsAllInputsValid,
                        builder: (context, snapshot) =>SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                          onPressed:(snapshot.data ?? false)
                          ?(){_viewModel.login();}
                          : null,
                          child: Text(AppStrings.login),
                          ),
                        ),
                       

                ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppPadding.p8,
                    left: AppPadding.p28,
                    right: AppPadding.p28,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child: Text(AppStrings.registerText,
                          style: Theme.of(context).textTheme.titleMedium,

                        ),
                      ),
                    ],
                  ),
                   ),
                 ]
               ),
             ),
           )
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
