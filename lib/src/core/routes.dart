import 'package:flutter/material.dart';

import '../features/authentication/views/login_view.dart';
import '../features/authentication/views/register_view.dart';
import '../features/authentication/views/verify_email_view.dart';
import '../features/books/views/books_view.dart';
import '../features/profile/views/profile_view.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const books = '/books';
  static const profile = '/profile';

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
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileView());

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
