
// abstract class BaseViewModel extends  BaseViewModelInputs with BaseViewModelOutputs{
//   //shared  variables and methods(functions) that will be used through any view model.

// }

// abstract class BaseViewModelInputs{

//   void start(); //will be called while init.of the view model

//   void dispose(); //will be called while closing of the view model
// }

// abstract class BaseViewModelOutputs {

// }
import 'dart:async';

import 'package:formation_app/presentation/common/state_renderer/state_render_impl.dart';

abstract class BaseViewModel extends Object
    with BaseViewModelInputs, BaseViewModelOutputs {
  // shared variables and methods(functions) that will be used through any view model.
  //StreamController _inputStateStreamController = BehaviorSubject<FlowState>();
  StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();

@override
  Sink get inputState => _inputStateStreamController.sink;
@override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);

@override
  void dispose() {
    _inputStateStreamController.close();
  }
}  


mixin BaseViewModelInputs {
  void start(); // will be called while init.of the view model

  void dispose(); // will be called while closing of the view 

  Sink get inputState;

}



mixin BaseViewModelOutputs {
  // Add any methods or properties that should be included in the outputs.

  Stream<FlowState> get outputState;
}
