import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/statusbar.dart';
import '../../books/views/books_view.dart';
import '../../books/views/favorite_books_view.dart';
import '../../profile/views/profile_view.dart';
import '../providers/home_current_page_index_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPageIndex = watch(homeCurrentPageIndex);

    return Statusbar(
      child: Scaffold(
        body: [
          const BooksView(),
          const FavoriteBooksView(),
          const ProfileView(),
        ][currentPageIndex.state],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex.state,
          onTap: (newIndex) => currentPageIndex.state = newIndex,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite Books',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
