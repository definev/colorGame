import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class UniqueColorGenerator {
  static List<Color> getColor(int level) {
    RandomColor randomColor = RandomColor();
    MaterialColor mainColor = randomColor.randomMaterialColor(
      colorHue: ColorHue.random,
      colorSaturation: ColorSaturation.mediumSaturation,
    );
    if (level < 30) {
      Color color = mainColor[400];
      Color relevantColor = mainColor[600];
      return [color, relevantColor];
    } else if (level < 60) {
      Color color = mainColor[300];
      Color relevantColor = mainColor[500];
      return [color, relevantColor];
    } else if (level < 80) {
      Color color = mainColor[200];
      Color relevantColor = mainColor[300];
      return [color, relevantColor];
    } else {
      Color color = mainColor[100];
      Color relevantColor = mainColor[200];
      return [color, relevantColor];
    }
  }

  static getRelevantColor(Color color) {}
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
