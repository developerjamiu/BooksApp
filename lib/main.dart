import 'src/services/base/api.dart';
import 'src/services/network/http_service.dart';
import 'src/services/network/i_network_service.dart';
import 'package:flutter/material.dart';

import 'src/core/theme.dart';
import 'src/views/home_view.dart';

void main() async {
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
