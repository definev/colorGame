import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'color_picker_event.dart';
part 'color_picker_state.dart';

class ColorPickerBloc extends Bloc<ColorPickerEvent, ColorPickerState> {
  @override
  ColorPickerState get initialState => ColorPickerInitial();

  @override
  Stream<ColorPickerState> mapEventToState(
    ColorPickerEvent event,
  ) async* {
    if (event is ReplayEvent) {
      yield ColorPickerInitial();
    } else if (event is GameOverEvent) {
      yield ColorPickerGameOver(event.isNewHighScore);
    } else if (event is PickEvent) {
      yield ColorPickerDone();
    } else if (event is ContinueEvent) {
      yield ColorPickerContinue();
    } else
      yield ColorPickerWaitting();
  }
}
