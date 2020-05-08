part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class OpenAppEvent extends LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String language;

  ChangeLanguageEvent({this.language});
}
