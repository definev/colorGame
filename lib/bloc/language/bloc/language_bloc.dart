import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colorgame/utils/preference.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  String _language = "us";

  String get language => _language;

  @override
  LanguageState get initialState => LanguageInitial();

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is OpenAppEvent) {
      _language = await getLanguage();
    }
    if (event is ChangeLanguageEvent) {
      _language = event.language;
      await setLanguage(_language);
    }
    yield LanguageInApp(language: language);
  }
}
