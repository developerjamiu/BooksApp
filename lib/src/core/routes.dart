import 'package:books/src/features/books/views/books_view.dart';
import 'package:flutter/material.dart';

import '../features/authentication/views/login_view.dart';
import '../features/authentication/views/register_view.dart';
import '../features/authentication/views/verify_email_view.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const books = '/books';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case books:
        return MaterialPageRoute(builder: (_) => const BooksView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
