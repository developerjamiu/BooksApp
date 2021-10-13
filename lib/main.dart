import 'package:http/http.dart';
import 'package:books/src/repositories/book_repository.dart';
import 'package:books/src/services/network/http_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/core/theme.dart';
import 'src/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final a = BookRepository(networkService: HttpService(client: Client()));
  a.getBooks();
  runApp(const ProviderScope(child: MyApp()));
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
