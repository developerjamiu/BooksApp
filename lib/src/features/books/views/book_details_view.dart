import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/dimensions.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utilities/model_converter.dart';
import '../../../widgets/pill.dart';
import '../../../widgets/spacing.dart';
import '../models/book.dart';
import '../models/favorite_book.dart';
import '../notifiers/favorite_books_notifier.dart';

class BookDetailsView extends StatelessWidget {
  final Book book;
  const BookDetailsView({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        actions: [
          Consumer(
            builder: (context, watch, child) {
              final notifier = watch(favoriteBooksNotifierProvider(book.id));

              return IconButton(
                onPressed: () {
                  final FavoriteBook fBook =
                      ModelConverter.toFavoriteBook(book);

                  context
                      .read(favoriteBooksNotifierProvider(book.id))
                      .addOrRemoveFromFavorite(fBook);
                },
                icon: notifier.isFavorite
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_outline),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.big),
        children: [
          Center(
            child: SizedBox(
              width: 767,
              child: Column(
                children: [
                  const Spacing.smallHeight(),
                  SizedBox(
                    height: 180,
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
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  const Spacing.smallWidth(),
                                  Text(
                                    (book.volumeInfo.averageRating ?? 0)
                                        .toString(),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Pill(text: book.volumeInfo.maturityRating),
                              ),
                              const Spacer(flex: 3),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacing.mediumHeight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppStrings.description, style: textTheme.bodyText1),
                      const Spacing.smallHeight(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: colorScheme.primary),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: Dimensions.medium),
                        child: Text(
                          book.volumeInfo.description ??
                              AppStrings.noDescription,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  const Spacing.mediumHeight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppStrings.authors, style: textTheme.bodyText1),
                      const Spacing.smallHeight(),
                      Row(
                        children: book.volumeInfo.authors == null
                            ? []
                            : book.volumeInfo.authors!
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Pill(text: e, width: null),
                                    ))
                                .toList(),
                      ),
                    ],
                  ),
                  const Spacing.mediumHeight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppStrings.categories, style: textTheme.bodyText1),
                      const Spacing.smallHeight(),
                      Row(
                        children: book.volumeInfo.categories == null
                            ? []
                            : book.volumeInfo.categories!
                                .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Pill(text: e, width: null),
                                    ))
                                .toList(),
                      ),
                    ],
                  ),
                  const Spacing.mediumHeight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppStrings.publisher, style: textTheme.bodyText1),
                      const Spacing.smallHeight(),
                      Text(
                          book.volumeInfo.publisher ?? AppStrings.notAvailable),
                    ],
                  ),
                  const Spacing.mediumHeight(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.publishedDate,
                        style: textTheme.bodyText1,
                      ),
                      const Spacing.smallHeight(),
                      Text(
                        book.volumeInfo.publishedDate ??
                            AppStrings.notAvailable,
                      ),
                    ],
                  ),
                  const Spacing.mediumHeight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
