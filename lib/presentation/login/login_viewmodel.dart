// **************************************************************************
// LoginViewModel Documentation
// **************************************************************************

import 'dart:async';

import 'package:formation_app/domain/usecase/login_usecase.dart';
import 'package:formation_app/presentation/base/base_view_model.dart';
import 'package:formation_app/presentation/commun/freezed_data_classes.dart';

/// `LoginViewModel` est une classe qui hérite de `BaseViewModel`
/// et utilise les mixins `LoginViewModelInput` et `LoginViewModelOutputs`.
/// Cette classe gère la logique de l'interface utilisateur pour l'écran de connexion,
/// en manipulant les entrées utilisateur et en interagissant avec le cas d'utilisation de connexion.

class LoginViewModel extends BaseViewModel with LoginViewModelInput, LoginViewModelOutputs {


  /************************* Initialisez les Variables *************************/ 
  
  /// StreamController pour gérer les flux de données du nom d'utilisateur.
  StreamController _userNamestreamController = StreamController<String>.broadcast();

  /// StreamController pour gérer les flux de données du mot de passe.
  StreamController _passwordstreamController = StreamController<String>.broadcast();

  /// StreamController pour valider si toutes les entrées sont correctes.
  StreamController _isAllInputsValidstreamController = StreamController<void>.broadcast();

  /// Objet `LoginObject` qui contient les données de connexion.
  var loginObject = LoginObject("", "");

  /// Instance de `LoginUseCase` pour exécuter la logique métier liée à la connexion.
  LoginUseCase _loginUseCase; 

  /// Constructeur de `LoginViewModel` qui prend un objet `LoginUseCase` en paramètre.
  LoginViewModel(this._loginUseCase);




  /************************* Inputs *************************/

  /// Ferme tous les StreamControllers lors de la destruction de l'objet.
  @override
  void dispose() {
    _userNamestreamController.close();
    _passwordstreamController.close();
    _isAllInputsValidstreamController.close();
  }

  @override
  void start() {
    // TODO: implémenter la méthode de démarrage si nécessaire
  }

  /// Retourne le `Sink` pour le flux de mot de passe.
  @override
  Sink get inputPassword => _passwordstreamController.sink;
  
  /// Retourne le `Sink` pour le flux du nom d'utilisateur.
  @override
  Sink get inputUsername => _userNamestreamController.sink;

  /// Retourne le `Sink` pour la validation des entrées.
  @override
  Sink get inputIsAllInputValid => _isAllInputsValidstreamController.sink;

  /// Méthode pour exécuter la connexion en utilisant `_loginUseCase`.
  @override
  login() async {
    (await _loginUseCase?.execute(LoginUseCaseInput(loginObject.userName, loginObject.password)))?.fold(
      (failure) => {
        // En cas d'échec, afficher le message d'erreur.
        print(failure.message)
      },
      (data) => {
        // En cas de succès, afficher le nom du client.
        print(data.customer?.name)
      }
    );
  }

  /// Définit le mot de passe et valide les entrées.
  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password); // Mise à jour de l'objet `LoginObject`
    _Validate(); // Validation des entrées
  }

  /// Définit le nom d'utilisateur et valide les entrées.
  @override
  setUserName(String userName) {
    inputUsername.add(userName);
    loginObject = loginObject.copyWith(userName: userName); // Mise à jour de l'objet `LoginObject`
    _Validate(); // Validation des entrées
  }
  


  /************************* Outputs *************************/

  /// Retourne un flux qui valide le mot de passe.
  @override
  Stream<bool> get outputIsPasswordValid => _passwordstreamController.stream.map((password) => _isPasswordValid(password));
  
  /// Retourne un flux qui valide le nom d'utilisateur.
  @override
  Stream<bool> get outputIsUserNameValid => _userNamestreamController.stream.map((userName) => _isUserNameValid(userName));

  /// Retourne un flux qui valide l'ensemble des entrées.
  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidstreamController.stream.map((_) => _isAllInputsVlid());



  /************************* Fonctions Privées *************************/

  /// Fonction privée pour valider toutes les entrées.
  void _Validate() {
    inputIsAllInputValid.add(null);
  }

  /// Valide le mot de passe : retourne `true` si le mot de passe n'est pas vide.
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }
  
  /// Valide l'ensemble des entrées : retourne `true` si le nom d'utilisateur et le mot de passe sont valides.
  bool _isAllInputsVlid() {
    return _isUserNameValid(loginObject.userName) && _isPasswordValid(loginObject.password);
  }

  /// Valide le nom d'utilisateur : retourne `true` si le nom d'utilisateur n'est pas vide.
  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }
}

/// `LoginViewModelInput` définit les fonctions pour gérer les actions utilisateur
/// telles que la définition du nom d'utilisateur, du mot de passe, et la connexion.
mixin LoginViewModelInput {
  void setUserName(String userName);
  void setPassword(String password);
  void login();

  Sink get inputUsername;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

/// `LoginViewModelOutputs` définit les flux de sortie pour valider les entrées
/// telles que le nom d'utilisateur, le mot de passe, et l'ensemble des entrées.
mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<void> get outputIsAllInputsValid;
}
