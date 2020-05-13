import 'package:colorgame/bloc/bloc.dart';
import 'package:colorgame/utils/utils.dart';
import 'package:colorgame/view/game_screen/normal_mode.dart';
import 'package:colorgame/view/game_screen/speed_mode.dart';
import 'package:colorgame/widget/neu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class GameMode extends StatefulWidget {
  @override
  _GameModeState createState() => _GameModeState();
}

class _GameModeState extends State<GameMode> {
  LanguageBloc _languageBloc;

  changeLanguage(String language) {
    if (_languageBloc.language != "us") {
      _languageBloc.add(ChangeLanguageEvent(language: "us"));
      setState(() {});
    } else if (_languageBloc.language != "vn") {
      _languageBloc.add(ChangeLanguageEvent(language: "vn"));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    _languageBloc = Provider.of<LanguageBloc>(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.lightShadow, AppColors.darkShadow],
          ),
        ),
        child: Stack(
          children: [
            BlocBuilder<LanguageBloc, LanguageState>(
                bloc: _languageBloc,
                builder: (context, state) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _header(context),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: _highScore(
                                      context, _languageBloc.language),
                                )
                              ]))
                        ])),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
                child: _playModePick(context, _languageBloc.language),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _header(BuildContext context) {
    return Center(
      child: Text(
        'Color Game',
        style: TextStyle(
          fontWeight: FontWeight.w100,
          fontFamily: 'Bungee Inline',
          fontSize: MediaQuery.of(context).size.width / 7.5,
          color: AppColors.textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Column _highScore(BuildContext context, String language) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<HighScoreBloc, HighScoreState>(
          bloc: Provider.of<HighScoreBloc>(context),
          builder: (context, state) {
            if (state is HighScoreValue) {
              return Text(
                language == 'us'
                    ? 'High score: ${state.score}'
                    : 'Điểm cao: ${state.score}',
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Bungee Inline',
                  fontSize: MediaQuery.of(context).size.width / 10.5,
                  color: AppColors.textColor,
                ),
                textAlign: TextAlign.center,
              );
            }
            return Container();
          },
        ),
        SizedBox(height: 20),
        _languageChoose(),
      ],
    );
  }

  Column _playModePick(BuildContext context, String language) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      NeuButton(
        shadowLength: 4,
        shadowFallLength: 0,
        position: 10,
        height: MediaQuery.of(context).size.height / 7.1,
        width: MediaQuery.of(context).size.width / 1.5,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language == 'us' ? 'Normal mode' : 'Chơi thường',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Bungee',
                    fontSize: MediaQuery.of(context).size.width / 18,
                    color: AppColors.textColor,
                  ),
                ),
                Image.asset('assets/arrow.png',
                    height: MediaQuery.of(context).size.height / 20),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: BlocProvider<ColorPickerBloc>(
                create: (context) => ColorPickerBloc(),
                child: NormalMode(),
              ),
            ),
          );
        },
      ),
      NeuButton(
        shadowLength: 4,
        shadowFallLength: 0,
        position: 10,
        height: MediaQuery.of(context).size.height / 7.1,
        width: MediaQuery.of(context).size.width / 1.5,
        borderRadius: BorderRadius.circular(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  language == 'us' ? 'Speed mode' : 'Chơi nhanh',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Bungee',
                      fontSize: MediaQuery.of(context).size.width / 18,
                      color: AppColors.textColor),
                ),
                Image.asset('assets/arrow.png',
                    height: MediaQuery.of(context).size.height / 20),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: BlocProvider<ColorPickerBloc>(
                create: (context) => ColorPickerBloc(),
                child: SpeedMode(),
              ),
            ),
          );
        },
      ),
    ]);
  }

  BlocBuilder<LanguageBloc, LanguageState> _languageChoose() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: _languageBloc,
      builder: (context, state) {
        if (state is LanguageInApp) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NeuButton(
                  isChoose: state.language == "vn" ? true : false,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 10,
                  ),
                  position: 7,
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  shadowLength: 4,
                  onTap: () {
                    if (_languageBloc.language != "vn") {
                      _languageBloc.add(ChangeLanguageEvent(language: "vn"));
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          'assets/vn.png',
                        ),
                      ),
                    ),
                  ),
                ),
                NeuButton(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 10,
                  ),
                  position: 7,
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  shadowLength: 4,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: MediaQuery.of(context).size.height / 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                NeuButton(
                  isChoose: state.language == "us" ? true : false,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 10,
                  ),
                  position: 7,
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  shadowLength: 4,
                  onTap: () {
                    if (_languageBloc.language != "us") {
                      _languageBloc.add(ChangeLanguageEvent(language: "us"));
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset('assets/us.png'),
                      ),
                    ),
                  ),
                ),
              ]);
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NeuButton(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height / 10),
              position: 7,
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              shadowLength: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset('assets/us.png'),
                  ),
                ),
              ),
            ),
            NeuButton(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height / 10,
              ),
              position: 7,
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              shadowLength: 4,
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: MediaQuery.of(context).size.height / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            NeuButton(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height / 10,
              ),
              position: 7,
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              shadowLength: 4,
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: MediaQuery.of(context).size.height / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            NeuButton(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height / 10),
              position: 7,
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.height / 10,
              shadowLength: 4,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset('assets/vn.png'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
