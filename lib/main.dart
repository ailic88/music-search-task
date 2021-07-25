import 'package:flutter/material.dart';

import 'core/injection_container.dart';
import 'features/home/home_page.dart';
void main() {
  initDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
