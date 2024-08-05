
// abstract class BaseViewModel extends  BaseViewModelInputs with BaseViewModelOutputs{
//   //shared  variables and methods(functions) that will be used through any view model.

// }

// abstract class BaseViewModelInputs{

//   void start(); //will be called while init.of the view model

//   void dispose(); //will be called while closing of the view model
// }

// abstract class BaseViewModelOutputs {

// }
abstract class BaseViewModel extends Object
    with BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and methods(functions) that will be used through any view model.
} 

mixin BaseViewModelInputs {
  void start(); // will be called while init.of the view model

  void dispose(); // will be called while closing of the view model
}

mixin BaseViewModelOutputs {
  // Add any methods or properties that should be included in the outputs.
}
