part of 'color_picker_bloc.dart';

@immutable
abstract class ColorPickerState {}

class ColorPickerInitial extends ColorPickerState {}

class ColorPickerWaitting extends ColorPickerState {}

class ColorPickerGameOver extends ColorPickerState {
  final bool isNewHighScore;

  ColorPickerGameOver(this.isNewHighScore);
}

class ColorPickerDone extends ColorPickerState {}

class ColorPickerContinue extends ColorPickerState {}
