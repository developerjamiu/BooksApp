class FavoriteBooksState {
  final bool isFavorite;

  const FavoriteBooksState._({required this.isFavorite});

  factory FavoriteBooksState.initial() => const FavoriteBooksState._(
        isFavorite: false,
      );

  FavoriteBooksState copyWith({bool? isFavorite}) => FavoriteBooksState._(
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
