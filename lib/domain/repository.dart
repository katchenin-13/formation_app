// **************************************************************************
// Interface Repository
//
// Cette interface définit le contrat pour le modèle Repository, qui est
// responsable de la gestion des opérations liées aux données, telles que
// l'authentification, la récupération de données, et plus encore. Le
// Repository est conçu pour abstraire la source des données (par exemple,
// réseau, base de données) et fournir une API propre pour le reste de
// l'application.
//
// La méthode login gère l'authentification des utilisateurs en acceptant
// un objet LoginRequest et en retournant un Future qui se résout en un type
// Either. Le type Either peut contenir soit un Failure (indiquant une
// erreur) soit une Authentication (indiquant un succès d'authentification).
//
// Cette interface doit être implémentée par des classes concrètes qui
// définissent la logique spécifique pour interagir avec la source de
// données souhaitée.
// **************************************************************************

import 'package:formation_app/data/network/failure.dart';
import 'package:formation_app/data/request/loginrequest.dart';
import 'package:formation_app/domain/model.dart';
import 'package:dartz/dartz.dart';

/// Classe abstraite qui définit le contrat pour les opérations de données
/// liées à l'authentification des utilisateurs. La méthode `login` doit être
/// implémentée par toute classe qui étend cette classe abstraite `Repository`.
///
/// Un exemple d'implémentation pourrait être l'interaction avec une API REST
/// pour authentifier l'utilisateur.
///
/// @returns [Future<Either<Failure, Authentication>>] - Un Future qui se
///          résout en un type Either, contenant soit un `Failure` en cas
///          d'erreur, soit un objet `Authentication` en cas de succès.
abstract class Repository {
  /// Authentifie un utilisateur en fonction de la [loginRequest] fournie.
  ///
  /// @param [loginRequest] - L'objet de requête contenant les informations
  ///        d'identification de l'utilisateur (par exemple, nom d'utilisateur
  ///        et mot de passe).
  ///
  /// @returns [Future<Either<Failure, Authentication>>] - Un Future qui se
  ///          résout en un type Either, contenant soit un `Failure` en cas
  ///          d'erreur, soit un objet `Authentication` en cas de succès.
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
}
