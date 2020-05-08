import 'dart:math';

import 'package:colorgame/bloc/color_picker/bloc/color_picker_bloc.dart';
import 'package:colorgame/bloc/high_score/bloc/high_score_bloc.dart';
import 'package:colorgame/utils/color_generator.dart';
import 'package:colorgame/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPicker extends StatefulWidget {
  final int numOfColor;
  final int level;

  const ColorPicker({Key key, this.numOfColor, this.level}) : super(key: key);
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  ColorPickerBloc _colorPickerBloc;
  Color rightColor;
  Color differentColor;
  int randomNode = 0;
  Random random = Random();
  bool onLongPress = false;

  @override
  void initState() {
    super.initState();
    randomNode = random.nextInt(widget.numOfColor * widget.numOfColor);
    setNewColor();
  }

  EdgeInsets _margin(bool onPress) {
    if (widget.numOfColor == 3) {
      if (onPress) {
        return EdgeInsets.all(10);
      } else {
        return EdgeInsets.all(5);
      }
    } else if (widget.numOfColor == 4) {
      if (onPress) {
        return EdgeInsets.all(10);
      } else {
        return EdgeInsets.all(6);
      }
    } else if (widget.numOfColor == 5) {
      if (onPress) {
        return EdgeInsets.all(5);
      } else {
        return EdgeInsets.all(2.5);
      }
    } else {
      if (onPress) {
        return EdgeInsets.all(15);
      } else {
        return EdgeInsets.all(10);
      }
    }
  }

  setNewColor() {
    randomNode = random.nextInt(widget.numOfColor * widget.numOfColor);
    List<Color> _color = UniqueColorGenerator.getColor(widget.level);
    rightColor = _color[0];
    differentColor = _color[1];
  }

  @override
  Widget build(BuildContext context) {
    _colorPickerBloc = BlocProvider.of<ColorPickerBloc>(context);
    return GridView.count(
        crossAxisCount: widget.numOfColor,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        children: List.generate(
            widget.numOfColor * widget.numOfColor,
            (index) => GestureDetector(
                key: Key('$index'),
                onTap: () {
                  setState(() {
                    onLongPress = true;
                  });
                  Future.delayed(Duration(milliseconds: 150), () {
                    setState(() {
                      onLongPress = false;
                    });
                    Future.delayed(Duration(milliseconds: 150), () {
                      if (randomNode == index) {
                        _colorPickerBloc.add(PickEvent());
                        setState(() {
                          setNewColor();
                        });
                      } else {
                        _colorPickerBloc.add(GameOverEvent(
                            highScore < widget.level ? true : false));
                      }
                    });
                  });
                },
                onLongPress: () {
                  setState(() => onLongPress = true);
                },
                onLongPressEnd: (details) {
                  setState(() => onLongPress = false);
                },
                child: AnimatedContainer(
                    margin: _margin(onLongPress),
                    duration: Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                        color: index != randomNode
                            ? rightColor.mix(Colors.amber, -.1)
                            : differentColor.mix(Colors.amber, -.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.lightShadow,
                              offset: Offset(-5, -5),
                              blurRadius: 20,
                              spreadRadius: -10),
                          BoxShadow(
                              color: AppColors.darkShadow,
                              offset: Offset(5, 5),
                              blurRadius: 20,
                              spreadRadius: -10)
                        ])))));
  }
}
