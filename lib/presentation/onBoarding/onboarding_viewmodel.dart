import 'dart:async';

import 'package:formation_app/domain/model.dart';
import 'package:formation_app/presentation/base/base_view_model.dart';
import 'package:formation_app/presentation/resources/assets_manager.dart';
import 'package:formation_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  
  //variable
  //stream controllers
  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;


  //la fonction dispose sera appellee lorsque l'objet sera detruit
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    //initialiser la liste des sliders
  _list = _getSliderData();
  //envoyer les sliders au view model
  _postDataToView();
  }
  

  /// Returns the next index in the list after the current index. If the current index is already the last index,
  /// it will wrap around to the first index and return it.
  ///
  /// Returns:
  /// The next index in the list after the current index.
  @override
  int goNext() {
    
     int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; //infinite loop to go to first item inside the slider
    }
    _postDataToView();

    return _currentIndex;

  }
  
  @override
  int goPrevious() {
    
      int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; //infinite loop to go to length of slider list
    }
    _postDataToView();

    return _currentIndex;
  }
  
  @override
  void onPageChanged(int index) {
   _currentIndex = index;
   _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject ) => sliderViewObject );
  
  //les fonctions private de notre view model
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
    
  _postDataToView(){
    //envoyer les sliders au view model
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }
}


//inputs mean the orders of our view model will recieve from our view
mixin OnBoardingViewModelInputs {
  int  goNext(); //when user clicks on right orrow button

  int  goPrevious(); //when user clicks on left orrow button

  void onPageChanged(int index);//when page changes

  Sink  get inputSliderViewObject; //this is the way to add data to the stream ... Stream input
    
}

//outputs mean the orders  that will be send from our view model  to our view
  mixin OnBoardingViewModelOutputs{ 
  //will be implement it later
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject{
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  
  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);

} 