part of 'high_score_bloc.dart';

@immutable
abstract class HighScoreEvent {}

class OpenHighScoreEvent extends HighScoreEvent {}

class SetHighScoreEvent extends HighScoreEvent {
  final int score;

  SetHighScoreEvent(this.score);
}
