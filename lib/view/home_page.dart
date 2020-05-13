import 'package:colorgame/bloc/bloc.dart';
import 'package:colorgame/utils/utils.dart';
import 'package:colorgame/view/game_mode.dart';
import 'package:colorgame/widget/neu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LanguageBloc _languageBloc;
  HighScoreBloc _highScoreBloc;
  bool _isInit = false;

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
    _highScoreBloc = Provider.of<HighScoreBloc>(context);
    if (_isInit == false) {
      _languageBloc.add(OpenAppEvent());
      _highScoreBloc.add(OpenHighScoreEvent());
      _isInit = true;
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightShadow,
              AppColors.darkShadow,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: _header(context),
            ),
            Expanded(
              flex: 2,
              child: _body(),
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
          fontSize: MediaQuery.of(context).size.height / 13.5,
          color: AppColors.textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  BlocBuilder<LanguageBloc, LanguageState> _body() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: _languageBloc,
      builder: (context, langState) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: _play(context, _languageBloc.language),
            ),
            Expanded(
              flex: 2,
              child: _highScore(context, _languageBloc.language),
            ),
          ],
        );
      },
    );
  }

  Widget _highScore(BuildContext context, String language) {
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
                  fontSize: MediaQuery.of(context).size.height / 20,
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

  Center _play(BuildContext context, String language) {
    return Center(
      child: NeuButton(
        shadowLength: 4,
        shadowFallLength: 0,
        position: 10,
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height / 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(language == 'us' ? 'Play' : 'Chơi',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Bungee',
                        fontSize: MediaQuery.of(context).size.height / 17,
                        color: AppColors.textColor,
                      )),
                  Image.asset('assets/background.png', height: 45),
                ])),
        onTap: () {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: GameMode()));
        },
      ),
    );
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
                                ))))),
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
                                child: Image.asset('assets/us.png')))))
              ]);
        }
      },
    );
  }
}
