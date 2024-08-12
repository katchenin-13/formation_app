// **************************************************************************
// OnBoardingViewModel Documentation
// **************************************************************************

import 'dart:async';

import 'package:formation_app/domain/model/model.dart';
import 'package:formation_app/presentation/base/base_view_model.dart';
import 'package:formation_app/presentation/resources/assets_manager.dart';
import 'package:formation_app/presentation/resources/strings_manager.dart';

/// `OnBoardingViewModel` est une classe qui gère la logique de l'interface utilisateur pour l'écran d'onboarding.
/// Elle hérite de `BaseViewModel` et utilise les mixins `OnBoardingViewModelInputs` et `OnBoardingViewModelOutputs`.

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {

  /// `OnBoardingViewModel` est une classe qui gère la logique de l'interface utilisateur pour l'écran d'onboarding.
  /// Elle hérite de `BaseViewModel` et utilise les mixins `OnBoardingViewModelInputs` et `OnBoardingViewModelOutputs`.

  // ############## Initialisez les Variables ##############
 // ############## Déclarations des Variables ##############

  /// `StreamController` pour gérer les flux de données du slider.
  final StreamController _streamController = StreamController<SliderViewObject>();

  /// Liste des objets `SliderObject` représentant les données de chaque slide.
  late final List<SliderObject> _list;

  /// Index actuel du slider.
  int _currentIndex = 0;




 // ############## Inputs ##############

  /// La méthode `dispose` est appelée lorsque l'objet est détruit pour libérer les ressources.
  @override
  void dispose() {
    _streamController.close();
  }

  /// Méthode `start` appelée pour initialiser la liste des sliders et envoyer les données au ViewModel.
  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  /// Retourne l'index suivant dans la liste après l'index actuel.
  /// Si l'index actuel est déjà le dernier, il boucle et retourne le premier index.
  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // Boucle infinie pour revenir au premier élément du slider
    }
    _postDataToView();
    return _currentIndex;
  }

  /// Retourne l'index précédent dans la liste avant l'index actuel.
  /// Si l'index actuel est déjà le premier, il boucle et retourne le dernier index.
  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1; // Boucle infinie pour revenir au dernier élément du slider
    }
    _postDataToView();
    return _currentIndex;
  }

  /// Met à jour l'index actuel lorsque la page change.
  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  /// Retourne le `Sink` pour le flux de `SliderViewObject`.
  @override
  Sink get inputSliderViewObject => _streamController.sink;



  //############## Outputs ##############

  /// Retourne un flux de `SliderViewObject` qui mappe les données du slider.
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);





  //############## Fonctions Privées ##############

  /// Retourne une liste de données pour les sliders.
  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1,
          AppStrings.onBoardingSubTitle1,
          ImageAssets.onboardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2,
          AppStrings.onBoardingSubTitle2,
          ImageAssets.onboardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3,
          AppStrings.onBoardingSubTitle3,
          ImageAssets.onboardingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4,
          AppStrings.onBoardingSubTitle4,
          ImageAssets.onboardingLogo4,
        ),
      ];

  /// Envoie les données du slider au ViewModel.
  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }
}

/// `OnBoardingViewModelInputs` définit les fonctions pour gérer les actions utilisateur
/// telles que passer au slide suivant, précédent, et le changement de page.
mixin OnBoardingViewModelInputs {
  int goNext(); // Quand l'utilisateur clique sur le bouton de droite

  int goPrevious(); // Quand l'utilisateur clique sur le bouton de gauche

  void onPageChanged(int index); // Quand la page change

  Sink get inputSliderViewObject; // Pour ajouter des données au flux
}

/// `OnBoardingViewModelOutputs` définit les flux de sortie pour envoyer les données du slider à la vue.
mixin OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

/// `SliderViewObject` est une classe qui contient les données nécessaires pour afficher un slide.
class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);
}
