part of 'high_score_bloc.dart';

@immutable
abstract class HighScoreState {}

class HighScoreInitial extends HighScoreState {}

class HighScoreValue extends HighScoreState {
  final int score;

  HighScoreValue(this.score);
}
