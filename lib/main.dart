import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/routes.dart';
import 'src/core/theme.dart';
import 'src/features/startup/views/startup_view.dart';
import 'src/services/navigation_service.dart';
import 'src/services/snackbar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      theme: AppTheme.lightTheme,
      home: const StartupView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: context.read(navigationService).navigatorKey,
      scaffoldMessengerKey: context.read(snackbarService).scaffoldMessengerKey,
    );
  }
}
