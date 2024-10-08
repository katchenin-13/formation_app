// **************************************************************************
// Extensions pour Mapper les Objets de Réponse vers les Modèles de Domaine
// **************************************************************************

import 'package:formation_app/data/responses/responses.dart';
import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/app/extensions.dart';

const EMPTY = "";
const ZERO = 0;

/// Extension sur `CustomerResponse?` pour fournir une fonction de mapping vers le modèle de domaine `Customer`.
extension CustomerResponseMapper on CustomerResponse? {
  /// Convertit un objet nullable `CustomerResponse` en un objet non-nullable `Customer`.
  /// Cette méthode gère les valeurs nulles en fournissant des valeurs par défaut :
  /// - `id` est mappé à une chaîne vide si nul.
  /// - `name` est mappé à une chaîne vide si nul.
  /// - `numOfNotifications` est mappé à zéro si nul.
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY, // Mappe `id` à une chaîne vide si nul.
        this?.name?.orEmpty() ??
            EMPTY, // Mappe `name` à une chaîne vide si nul.
        this?.numOfNotifications?.orZero() ??
            ZERO // Mappe `numOfNotifications` à zéro si nul.
        );
  }
}

/// Extension sur `ContactsResponse?` pour fournir une fonction de mapping vers le modèle de domaine `Contacts`.
extension ContactsResponseMapper on ContactsResponse? {
  /// Convertit un objet nullable `ContactsResponse` en un objet non-nullable `Contacts`.
  /// Cette méthode gère les valeurs nulles en fournissant des valeurs par défaut :
  /// - `phone` est mappé à une chaîne vide si nul.
  /// - `email` est mappé à une chaîne vide si nul.
  /// - `link` est mappé à une chaîne vide si nul.
  
  Contacts toDomain() {
    return Contacts(
        this?.phone?.orEmpty() ??EMPTY, // Mappe `phone` à une chaîne vide si nul.
        this?.email?.orEmpty() ??EMPTY, // Mappe `email` à une chaîne vide si nul.
        this?.link?.orEmpty() ?? EMPTY // Mappe `link` à une chaîne vide si nul.
        );
  }
}

/// Extension sur `AuthenticationResponse?` pour fournir une fonction de mapping vers le modèle de domaine `Authentication`.
extension AuthenticationResponseMapper on AuthenticationResponse? {
  /// Convertit un objet nullable `AuthenticationResponse` en un objet non-nullable `Authentication`.
  ///
  /// Cette méthode mappe les objets imbriqués en utilisant leurs extensions respectives :
  /// - `customer` est mappé en utilisant `CustomerResponseMapper`.
  /// - `contacts` est mappé en utilisant `ContactsResponseMapper`.
  Authentication toDomain() {
    return Authentication(
        this?.customer ?.toDomain(), // Mappe `customer` en utilisant `CustomerResponseMapper`.
        this?.contacts ?.toDomain() // Mappe `contacts` en utilisant `ContactsResponseMapper`.
        );
  }

}
/// Extension sur `String` pour fournir une fonction de mapping vers le modèle de domaine `Failure`.
extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
    String toDomain() {
        return this?.support?.orEmpty() ?? EMPTY;
    }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY);
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(this?.id?.orZero() ?? ZERO, this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                Iterable.empty())
            .cast<Service>()
            .toList();

    List<Store> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                Iterable.empty())
            .cast<Store>()
            .toList();

    List<BannerAd> mappedBanners =
        (this?.data?.banners?.map((bannerAd) => bannerAd.toDomain()) ??
                Iterable.empty())
            .cast<BannerAd>()
            .toList();

    var data = HomeData(mappedServices, mappedStores, mappedBanners);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
        this?.id?.orZero() ?? ZERO,
        this?.title?.orEmpty() ?? EMPTY,
        this?.image?.orEmpty() ?? EMPTY,
        this?.details?.orEmpty() ?? EMPTY,
        this?.services?.orEmpty() ?? EMPTY,
        this?.about?.orEmpty() ?? EMPTY);
  }
}
