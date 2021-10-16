import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/statusbar.dart';
import '../../books/views/books_view.dart';
import '../../profile/views/profile_view.dart';

final homeCurrentPageIndex = StateProvider.autoDispose((ref) => 0);

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPageIndex = watch(homeCurrentPageIndex);

    return Statusbar(
      child: Scaffold(
        body: [
          const BooksView(),
          const Scaffold(),
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
