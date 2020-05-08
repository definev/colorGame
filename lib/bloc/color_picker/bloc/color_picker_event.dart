part of 'color_picker_bloc.dart';

@immutable
abstract class ColorPickerEvent {}

class ReplayEvent extends ColorPickerEvent {}

class GameOverEvent extends ColorPickerEvent {
  final bool isNewHighScore;

  GameOverEvent(this.isNewHighScore);
}

class PickEvent extends ColorPickerEvent {}

class ContinueEvent extends ColorPickerEvent {}

