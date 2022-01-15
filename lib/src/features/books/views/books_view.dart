import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../widgets/pill.dart';
import '../../../widgets/responsive.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../models/book.dart';
import '../notifiers/books_notifier.dart';

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
            child: Center(
              child: SizedBox(
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.9,
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
                            AppStrings.booksHeading,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const Spacing.largeHeight(),
                          SearchTextField(controller: searchController),
                          const Spacing.largeHeight(),
                          Consumer(
                            builder: (context, ref, child) {
                              final query =
                                  ref.watch(booksNotifierProvider).searchQuery;

                              return Row(
                                children: [
                                  Text(
                                    query == '""'
                                        ? AppStrings.booksSubHeading
                                        : 'Result for $query',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  const Spacing.smallWidth(),
                                  query == '""'
                                      ? const Spacing.empty()
                                      : GestureDetector(
                                          onTap: () {
                                            searchController.clear();
                                            ref
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
                        builder: (context, ref, child) {
                          final booksNotifier =
                              ref.watch(booksNotifierProvider);

                          if (booksNotifier.state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (booksNotifier.state.isError) {
                            return const BooksErrorView();
                          } else {
                            return BookList(
                              books: booksNotifier.books,
                              moreDataAvailable:
                                  booksNotifier.moreDataAvailable,
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
        ),
      ),
    );
  }
}

class SearchTextField extends ConsumerWidget {
  final TextEditingController controller;

  const SearchTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AppColors.defaultShadow],
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (text) =>
            ref.read(booksNotifierProvider).getBooks(query: text),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 24,
            bottom: 16,
            right: Dimensions.medium,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: AppStrings.searchForBooks,
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

class BookList extends HookConsumerWidget {
  final List<Book> books;
  final bool moreDataAvailable;

  const BookList({
    Key? key,
    required this.books,
    required this.moreDataAvailable,
  }) : super(key: key);

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
    final booksScrollController = useScrollController();

    useEffect(() {
      void scrollListener() {
        if (booksScrollController.position.pixels ==
            booksScrollController.position.maxScrollExtent) {
          ref.read(booksNotifierProvider).getMoreBooks();
        }
      }

      booksScrollController.addListener(scrollListener);

      return () => booksScrollController.removeListener(scrollListener);
    }, [booksScrollController]);

    if (books.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () => ref.read(booksNotifierProvider).getBooks(),
        child: GridView.builder(
          controller: booksScrollController,
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
            AppStrings.noBooks,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
    }
  }
}

class BookListItem extends ConsumerWidget {
  final Book book;

  const BookListItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(navigationService).navigateToNamed(
            Routes.bookDetails,
            arguments: book,
          ),
      child: Container(
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
                          book.volumeInfo.imageLinks!.thumbnail
                              .replaceFirst('http', 'https'),
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
                  book.volumeInfo.authors == null
                      ? const Spacing.empty()
                      : Text(book.volumeInfo.authors![0]),
                  const Spacer(),
                  Text(
                    book.volumeInfo.title,
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const Spacing.smallWidth(),
                      Text((book.volumeInfo.averageRating ?? 0).toString()),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Pill(text: book.volumeInfo.maturityRating),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ],
        ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.errorBooks,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const Spacing.bigHeight(),
        ElevatedButton(
          onPressed: () => ref.refresh(booksNotifierProvider).getBooks(),
          child: const Text(AppStrings.retry),
        ),
      ],
    );
  }
}
