import 'package:flutter/material.dart';
import 'package:music_search_task/core/design_tokens/text_style_design_token.dart';

class CommunicationWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CommunicationWidget(this.text, {this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: textStyle ?? TextStyleDesignToken.bodyLg(),
        ),
      ),
    );
  }
}
