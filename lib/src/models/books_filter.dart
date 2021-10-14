class BooksFilter {
  final String queryString;
  final int currentPage;

  BooksFilter({
    required this.queryString,
    required this.currentPage,
  });

  BooksFilter copyWith({
    String? queryString,
    int? currentPage,
  }) {
    return BooksFilter(
      queryString: queryString ?? this.queryString,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BooksFilter &&
        other.queryString == queryString &&
        other.currentPage == currentPage;
  }

  @override
  int get hashCode => queryString.hashCode ^ currentPage.hashCode;
}
