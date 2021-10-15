import 'package:books/src/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/constants/colors.dart';
import '../core/constants/dimensions.dart';
import '../core/utilities/base_change_notifier.dart';
import '../models/book.dart';
import '../notifiers/books_notifier.dart';
import '../widgets/pill.dart';
import '../widgets/spacing.dart';
import '../widgets/statusbar.dart';

class BooksView extends HookWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.big,
                    right: Dimensions.big,
                    top: Dimensions.large,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Explore thousands of books on the go',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const Spacing.largeHeight(),
                      SearchTextField(controller: searchController),
                      const Spacing.largeHeight(),
                      Consumer(
                        builder: (context, watch, child) {
                          final query =
                              watch(booksNotifierProvider).searchQuery;

                          return Row(
                            children: [
                              Text(
                                query == '""'
                                    ? 'Famous Books'
                                    : 'Result for $query',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const Spacing.smallWidth(),
                              query == '""'
                                  ? const Spacing.empty()
                                  : GestureDetector(
                                      onTap: () {
                                        searchController.clear();
                                        context
                                            .read(booksNotifierProvider)
                                            .getBooks();
                                      },
                                      child: const Icon(Icons.cancel),
                                    )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Spacing.smallHeight(),
                Expanded(
                  child: Consumer(
                    builder: (context, watch, child) {
                      final booksNotifier = watch(booksNotifierProvider);

                      if (booksNotifier.state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (booksNotifier.state.isError) {
                        return const BooksErrorView();
                      } else {
                        return BookList(
                          books: booksNotifier.books,
                          moreDataAvailable: booksNotifier.moreDataAvailable,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AppColors.defaultShadow],
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (text) =>
            context.read(booksNotifierProvider).getBooks(query: text),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 24,
            bottom: 16,
            right: Dimensions.medium,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search for books...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search_sharp),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 64,
          ),
        ),
      ),
    );
  }
}

class BookList extends HookWidget {
  final List<Book> books;
  final bool moreDataAvailable;

  const BookList({
    Key? key,
    required this.books,
    required this.moreDataAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksScrollController = useScrollController();

    useEffect(() {
      void scrollListener() {
        if (booksScrollController.position.pixels ==
            booksScrollController.position.maxScrollExtent) {
          context.read(booksNotifierProvider).getMoreBooks();
        }
      }

      booksScrollController.addListener(scrollListener);

      return () => booksScrollController.removeListener(scrollListener);
    }, [booksScrollController]);

    if (books.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () => context.read(booksNotifierProvider).getBooks(),
        child: GridView.builder(
          controller: booksScrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(Dimensions.big),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 7 / 4,
            mainAxisSpacing: Dimensions.big,
            crossAxisSpacing: Dimensions.big,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            if (index == books.length - 1 && moreDataAvailable) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

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

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: book.volumeInfo.imageLinks == null
                  ? const Spacing.empty()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        book.volumeInfo.imageLinks!.thumbnail,
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
                book.volumeInfo.authors == null
                    ? const Spacing.empty()
                    : Text(book.volumeInfo.authors![0]),
                const Spacing.height(12),
                Text(
                  book.volumeInfo.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacing.height(12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const Spacing.smallWidth(),
                    Text((book.volumeInfo.averageRating ?? 0).toString()),
                  ],
                ),
                const Spacing.height(12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Pill(text: book.volumeInfo.maturityRating),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BooksErrorView extends StatelessWidget {
  const BooksErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Error displaying Books',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const Spacing.bigHeight(),
        ElevatedButton(
          onPressed: () => context.refresh(booksNotifierProvider).getBooks(),
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
