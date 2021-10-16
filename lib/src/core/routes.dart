import 'package:flutter/material.dart';

import '../features/authentication/views/login_view.dart';
import '../features/authentication/views/register_view.dart';
import '../features/authentication/views/verify_email_view.dart';
import '../features/books/models/book.dart';
import '../features/books/views/book_details_view.dart';
import '../features/books/views/books_view.dart';
import '../features/home/views/home_view.dart';
import '../features/profile/views/profile_view.dart';

class Routes {
  static const login = '/login';
  static const register = '/register';
  static const verifyEmail = '/verify-email';
  static const home = '/home';
  static const books = '/books';
  static const bookDetails = '/book-details';
  static const profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case books:
        return MaterialPageRoute(builder: (_) => const BooksView());
      case bookDetails:
        final book = settings.arguments as Book;
        return MaterialPageRoute(
          builder: (_) => BookDetailsView(book: book),
        );
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
