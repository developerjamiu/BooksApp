import 'package:books/src/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/routes.dart';
import 'src/core/theme.dart';
import 'src/services/snackbar_service.dart';
import 'src/features/authentication/views/login_view.dart';

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
      title: 'Books',
      theme: AppTheme.lightTheme,
      home: LoginView(),
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: context.read(navigationServiceProvider).navigatorKey,
      scaffoldMessengerKey:
          context.read(snackbarServiceProvider).scaffoldMessengerKey,
    );
  }
}
