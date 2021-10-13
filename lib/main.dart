import 'package:flutter/material.dart';

import 'src/core/theme.dart';
import 'src/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books',
      theme: AppTheme.lightTheme,
      home: const HomeView(),
    );
  }
}
