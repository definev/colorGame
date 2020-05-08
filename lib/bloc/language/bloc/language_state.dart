part of 'language_bloc.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageInApp extends LanguageState {
  final String language;

  LanguageInApp({this.language});
}
