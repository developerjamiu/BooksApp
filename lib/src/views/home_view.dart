import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dimensions.dart';
import '../widgets/pill.dart';
import '../widgets/spacing.dart';
import '../widgets/statusbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      const SearchTextField(),
                      const Spacing.largeHeight(),
                      Text(
                        'Famous Books',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                const Spacing.smallHeight(),
                Expanded(
                  child: GridView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(Dimensions.big),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 7 / 4,
                      mainAxisSpacing: Dimensions.big,
                      crossAxisSpacing: Dimensions.big,
                    ),
                    itemBuilder: (context, index) => const BookListItem(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AppColors.defaultShadow],
      ),
      child: TextField(
        textInputAction: TextInputAction.search,
        onSubmitted: (_) {
          debugPrint('hello');
        },
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
          prefixIcon: currentFocus.hasFocus
              ? GestureDetector(
                  onTap: () => currentFocus.unfocus(),
                  child: const Icon(Icons.arrow_back),
                )
              : const Icon(Icons.search_sharp),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 64,
          ),
        ),
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  const BookListItem({
    Key? key,
  }) : super(key: key);

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
            ),
          ),
          const Spacing.mediumWidth(),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('by Joshua Becker'),
                const Spacing.height(12),
                Text(
                  'The More of Less',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Spacing.height(12),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    Spacing.smallWidth(),
                    Text('4.5'),
                  ],
                ),
                const Spacing.height(12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Pill(text: 'Minimalism'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
