// **************************************************************************
// ErrorHandler Documentation
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:formation_app/data/network/failure.dart';

/// Enumération représentant les différentes sources d'erreur possibles pour les réponses API.
enum DataSource {
  SUCCESS, // Succès avec des données
  NO_CONTENT, // Succès sans contenu
  BAD_REQUEST, // Requête invalide
  FORBIDDEN, // Accès interdit
  UNAUTHORIZED, // Non autorisé
  NOT_FOUND, // Non trouvé
  INTERNAL_SERVER_ERROR, // Erreur interne du serveur
  CONNECT_TIMEOUT, // Timeout de connexion
  CANCEL, // Requête annulée
  RECEIVE_TIMEOUT, // Timeout de réception
  SEND_TIMEOUT, // Timeout d'envoi
  CACHE_ERROR, // Erreur de cache
  NO_INTERNET_CONNECTION, // Pas de connexion internet
  DEFAULT // Erreur par défaut
}

/// Classe pour la gestion des erreurs.
///
/// Cette classe permet de gérer les erreurs en se basant sur les erreurs reçues
/// des appels API via le package Dio.
class ErrorHandler implements Exception {
  late Failure failure;

  /// Constructeur pour la gestion des erreurs.
  ///
  /// Il prend en paramètre une erreur et attribue un `Failure` approprié basé
  /// sur le type d'erreur.
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // Erreur Dio, donc une erreur provenant de la réponse de l'API
      failure = _handleError(error);
    } else {
      // Erreur par défaut
      failure = DataSource.DEFAULT.getFailure();
    }
  }

  /// Méthode privée pour gérer les erreurs Dio.
  ///
  /// Cette méthode renvoie un objet `Failure` en fonction du type d'erreur Dio rencontrée.
  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERROR:
            return DataSource.INTERNAL_SERVER_ERROR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioExceptionType.badCertificate:
        return DataSource.DEFAULT.getFailure();
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        return DataSource.NOT_FOUND.getFailure();
      case DioExceptionType.unknown:
        return DataSource.DEFAULT.getFailure();
    }
  }
}

/// Extension pour l'énumération [DataSource] afin de gérer les erreurs.
///
/// Cette extension fournit des méthodes pour obtenir des objets `Failure`
/// associés à chaque type de source d'erreur.
extension DataSourceExtension on DataSource {
  /// Obtient l'objet `Failure` correspondant à la source d'erreur.
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

/// Classe pour les codes de réponse API.
///
/// Cette classe définit les codes de réponse utilisés pour indiquer le succès ou l'échec
/// des requêtes API.
class ResponseCode {
  static const int SUCCESS = 200; // Succès avec données
  static const int NO_CONTENT = 201; // Succès sans contenu
  static const int BAD_REQUEST = 400; // Requête invalide
  static const int FORBIDDEN = 403; // Accès interdit
  static const int UNAUTHORIZED = 401; // Non autorisé
  static const int NOT_FOUND = 404; // Non trouvé
  static const int INTERNAL_SERVER_ERROR = 500; // Erreur interne du serveur
  static const int DEFAULT = -1; // Erreur par défaut
  static const int CONNECT_TIMEOUT = -2; // Timeout de connexion
  static const int CANCEL = -3; // Requête annulée
  static const int RECEIVE_TIMEOUT = -4; // Timeout de réception
  static const int SEND_TIMEOUT = -5; // Timeout d'envoi
  static const int CACHE_ERROR = -6; // Erreur de cache
  static const int NO_INTERNET_CONNECTION = -7; // Pas de connexion internet
}

/// Classe pour les messages de réponse.
///
/// Cette classe définit les messages associés aux codes de réponse API.
class ResponseMessage {
  static const String SUCCESS = "Success";
  static const String NO_CONTENT = "Success with no content";
  static const String BAD_REQUEST = "Bad request, Try again later";
  static const String FORBIDDEN = "Forbidden request, Try again later";
  static const String UNAUTHORIZED = "User is unauthorized, Try again later";
  static const String NOT_FOUND = "Url is Not found, Try again later";
  static const String INTERNAL_SERVER_ERROR =
      "Something went wrong, Try again later";
  static const String DEFAULT = "Something went wrong, Try again later";
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "request is cancelled, Try again later";
  static const String RECEIVE_TIMEOUT = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}

/// Classe pour les statuts internes de l'API.
///
/// Cette classe définit les statuts internes pour représenter le succès ou l'échec.
class ApiInternalStatus {
  static const int SUCCESS = 0; // Succès
  static const int FAILURE = 1; // Échec
}
