import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../../widgets/pill.dart';
import '../../../widgets/responsive.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../models/favorite_book.dart';
import '../notifiers/favorite_books_notifier.dart';
import '../providers/favorite_books_provider.dart';

class FavoriteBooksView extends HookConsumerWidget {
  const FavoriteBooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Center(
              child: SizedBox(
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.big,
                        right: Dimensions.big,
                        top: Dimensions.big,
                        bottom: Dimensions.small,
                      ),
                      child: Text(
                        AppStrings.favoriteBooks,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const Spacing.smallHeight(),
                    Expanded(
                      child: Consumer(
                        builder: (context, watch, child) {
                          final favoriteBooks =
                              ref.watch(favoriteBooksProvider);

                          return favoriteBooks.when(
                            data: (data) => BookList(books: data),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (_, __) => const BooksErrorView(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BookList extends HookConsumerWidget {
  final List<FavoriteBook> books;

  const BookList({Key? key, required this.books}) : super(key: key);

  int getCrossAxisCountByPlatform(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return 1;
    } else if (Responsive.isMobile(context)) {
      return 1;
    } else if (Responsive.isLaptop(context)) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (books.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async => ref.refresh(favoriteBooksProvider),
        child: GridView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.big),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getCrossAxisCountByPlatform(context),
            childAspectRatio: 7 / 4,
            mainAxisSpacing: Dimensions.big,
            crossAxisSpacing: Dimensions.big,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return BookListItem(book: books[index]);
          },
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Books to display',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
  }
}

class BookListItem extends ConsumerWidget {
  final FavoriteBook book;

  const BookListItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.small),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.defaultShadow],
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green.shade50,
              ),
              height: double.infinity,
              child: book.image == null
                  ? const Spacing.empty()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        book.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const Spacing.mediumWidth(),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 3),
                book.authors == null
                    ? const Spacing.empty()
                    : Text(book.authors![0]),
                const Spacer(),
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const Spacing.smallWidth(),
                    Text((book.averageRatings ?? 0).toString()),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Pill(text: book.maturityRating),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(favoriteBooksNotifierProvider(book.id))
                            .addOrRemoveFromFavorite(book);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BooksErrorView extends ConsumerWidget {
  const BooksErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.errorBooks,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Spacing.bigHeight(),
          ElevatedButton(
            onPressed: () => ref.refresh(favoriteBooksProvider),
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}
