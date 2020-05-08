import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:colorgame/utils/preference.dart';
import 'package:meta/meta.dart';

part 'high_score_event.dart';
part 'high_score_state.dart';

int highScore = 0;

class HighScoreBloc extends Bloc<HighScoreEvent, HighScoreState> {
  @override
  HighScoreState get initialState => HighScoreInitial();

  @override
  Stream<HighScoreState> mapEventToState(
    HighScoreEvent event,
  ) async* {
    if (event is OpenHighScoreEvent) {
      highScore = await getHighScore();
    }
    if (event is SetHighScoreEvent) {
      await setHighScore(event.score);
      highScore = await getHighScore();
    }
    yield HighScoreValue(highScore);
  }
}
