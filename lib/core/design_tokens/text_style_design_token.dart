import 'package:flutter/material.dart';

import 'colors_design_token.dart';

class TextStyleDesignToken {
  static const Color _defaultColor = ColorsDesignToken.black;

  static TextStyle titleLg({Color color = _defaultColor}) {
    return TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w700);
  }

  static TextStyle titleMd({Color color = _defaultColor}) {
    return TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w700);
  }

  static TextStyle titleSm({Color color = _defaultColor}) {
    return TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w700);
  }

  static TextStyle bodyLg({Color color = _defaultColor}) {
    return TextStyle(color: color, fontSize: 16);
  }

  static TextStyle bodyMd({Color color = _defaultColor}) {
    return TextStyle(color: color, fontSize: 14);
  }
}
