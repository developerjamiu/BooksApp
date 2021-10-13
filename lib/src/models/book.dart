class BookResponse {
  final List<Book> books;

  BookResponse({
    required this.books,
  });

  factory BookResponse.fromMap(Map<String, dynamic> map) {
    return BookResponse(
      books: List<Book>.from(map['items']?.map((x) => Book.fromMap(x))),
    );
  }

  @override
  String toString() => 'BookResponse(books: $books)';
}

class Book {
  final String kind;
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfo volumeInfo;
  final SaleInfo saleInfo;
  final AccessInfo accessInfo;
  final SearchInfo? searchInfo;

  Book({
    required this.kind,
    required this.id,
    required this.etag,
    required this.selfLink,
    required this.volumeInfo,
    required this.saleInfo,
    required this.accessInfo,
    required this.searchInfo,
  });

  factory Book.fromMap(Map<String, dynamic> map) => Book(
        kind: map['kind'],
        id: map['id'],
        etag: map['etag'],
        selfLink: map['selfLink'],
        volumeInfo: VolumeInfo.fromMap(map['volumeInfo']),
        saleInfo: SaleInfo.fromMap(map['saleInfo']),
        accessInfo: AccessInfo.fromMap(map['accessInfo']),
        searchInfo: map['searchInfo'] != null
            ? SearchInfo.fromMap(map['searchInfo'])
            : null,
      );

  @override
  String toString() {
    return 'Book(kind: $kind, id: $id, etag: $etag, selfLink: $selfLink, volumeInfo: $volumeInfo, saleInfo: $saleInfo, accessInfo: $accessInfo, searchInfo: $searchInfo)';
  }
}

class VolumeInfo {
  final String title;
  final List<String>? authors;
  final String? publisher;
  final String publishedDate;
  final String? description;
  final List<IndustryIdentifiers> industryIdentifiers;
  final ReadingModes readingModes;
  final int? pageCount;
  final String printType;
  final List<String>? categories;
  final num? averageRating;
  final int? ratingsCount;
  final String maturityRating;
  final bool allowAnonLogging;
  final String contentVersion;
  final PanelizationSummary? panelizationSummary;
  final ImageLinks? imageLinks;
  final String language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;

  VolumeInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.industryIdentifiers,
    required this.readingModes,
    required this.pageCount,
    required this.printType,
    required this.categories,
    required this.averageRating,
    required this.ratingsCount,
    required this.maturityRating,
    required this.allowAnonLogging,
    required this.contentVersion,
    required this.panelizationSummary,
    required this.imageLinks,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
  });

  factory VolumeInfo.fromMap(Map<String, dynamic> map) => VolumeInfo(
        title: map['title'],
        authors:
            map['authors'] != null ? List<String>.from(map['authors']) : null,
        publisher: map['publisher'],
        publishedDate: map['publishedDate'],
        description: map['description'],
        industryIdentifiers: List<IndustryIdentifiers>.from(
            map['industryIdentifiers']
                ?.map((x) => IndustryIdentifiers.fromMap(x))),
        readingModes: ReadingModes.fromMap(map['readingModes']),
        pageCount: map['pageCount'],
        printType: map['printType'],
        categories: map['categories'] != null
            ? List<String>.from(map['categories'])
            : null,
        averageRating: map['averageRating'],
        ratingsCount: map['ratingsCount'],
        maturityRating: map['maturityRating'],
        allowAnonLogging: map['allowAnonLogging'],
        contentVersion: map['contentVersion'],
        panelizationSummary: map['panelizationSummary'] != null
            ? PanelizationSummary.fromMap(map['panelizationSummary'])
            : null,
        imageLinks: map['imageLinks'] != null
            ? ImageLinks.fromMap(map['imageLinks'])
            : null,
        language: map['language'],
        previewLink: map['previewLink'],
        infoLink: map['infoLink'],
        canonicalVolumeLink: map['canonicalVolumeLink'],
      );

  @override
  String toString() {
    return 'VolumeInfo(title: $title, authors: $authors, publisher: $publisher, publishedDate: $publishedDate, description: $description, industryIdentifiers: $industryIdentifiers, readingModes: $readingModes, pageCount: $pageCount, printType: $printType, categories: $categories, averageRating: $averageRating, ratingsCount: $ratingsCount, maturityRating: $maturityRating, allowAnonLogging: $allowAnonLogging, contentVersion: $contentVersion, panelizationSummary: $panelizationSummary, imageLinks: $imageLinks, language: $language, previewLink: $previewLink, infoLink: $infoLink, canonicalVolumeLink: $canonicalVolumeLink)';
  }
}

class IndustryIdentifiers {
  final String type;
  final String identifier;

  IndustryIdentifiers({
    required this.type,
    required this.identifier,
  });

  factory IndustryIdentifiers.fromMap(Map<String, dynamic> map) =>
      IndustryIdentifiers(
        type: map['type'],
        identifier: map['identifier'],
      );

  @override
  String toString() =>
      'IndustryIdentifiers(type: $type, identifier: $identifier)';
}

class ReadingModes {
  final bool text;
  final bool image;

  ReadingModes({
    required this.text,
    required this.image,
  });

  factory ReadingModes.fromMap(Map<String, dynamic> map) => ReadingModes(
        text: map['text'],
        image: map['image'],
      );

  @override
  String toString() => 'ReadingModes(text: $text, image: $image)';
}

class PanelizationSummary {
  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  PanelizationSummary({
    required this.containsEpubBubbles,
    required this.containsImageBubbles,
  });

  factory PanelizationSummary.fromMap(Map<String, dynamic> map) =>
      PanelizationSummary(
        containsEpubBubbles: map['containsEpubBubbles'],
        containsImageBubbles: map['containsImageBubbles'],
      );

  @override
  String toString() =>
      'PanelizationSummary(containsEpubBubbles: $containsEpubBubbles, containsImageBubbles: $containsImageBubbles)';
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory ImageLinks.fromMap(Map<String, dynamic> map) => ImageLinks(
        smallThumbnail: map['smallThumbnail'],
        thumbnail: map['thumbnail'],
      );

  @override
  String toString() =>
      'ImageLinks(smallThumbnail: $smallThumbnail, thumbnail: $thumbnail)';
}

class SaleInfo {
  final String country;
  final String saleability;
  final bool isEbook;

  SaleInfo({
    required this.country,
    required this.saleability,
    required this.isEbook,
  });

  factory SaleInfo.fromMap(Map<String, dynamic> map) => SaleInfo(
        country: map['country'],
        saleability: map['saleability'],
        isEbook: map['isEbook'],
      );

  @override
  String toString() =>
      'SaleInfo(country: $country, saleability: $saleability, isEbook: $isEbook)';
}

class AccessInfo {
  final String country;
  final String viewability;
  final bool embeddable;
  final bool publicDomain;
  final String textToSpeechPermission;
  final Epub epub;
  final Epub pdf;
  final String webReaderLink;
  final String accessViewStatus;
  final bool quoteSharingAllowed;

  AccessInfo({
    required this.country,
    required this.viewability,
    required this.embeddable,
    required this.publicDomain,
    required this.textToSpeechPermission,
    required this.epub,
    required this.pdf,
    required this.webReaderLink,
    required this.accessViewStatus,
    required this.quoteSharingAllowed,
  });

  factory AccessInfo.fromMap(Map<String, dynamic> map) => AccessInfo(
        country: map['country'],
        viewability: map['viewability'],
        embeddable: map['embeddable'],
        publicDomain: map['publicDomain'],
        textToSpeechPermission: map['textToSpeechPermission'],
        epub: Epub.fromMap(map['epub']),
        pdf: Epub.fromMap(map['pdf']),
        webReaderLink: map['webReaderLink'],
        accessViewStatus: map['accessViewStatus'],
        quoteSharingAllowed: map['quoteSharingAllowed'],
      );

  @override
  String toString() {
    return 'AccessInfo(country: $country, viewability: $viewability, embeddable: $embeddable, publicDomain: $publicDomain, textToSpeechPermission: $textToSpeechPermission, epub: $epub, pdf: $pdf, webReaderLink: $webReaderLink, accessViewStatus: $accessViewStatus, quoteSharingAllowed: $quoteSharingAllowed)';
  }
}

class Epub {
  final bool isAvailable;

  Epub({required this.isAvailable});

  factory Epub.fromMap(Map<String, dynamic> json) => Epub(
        isAvailable: json['isAvailable'],
      );

  @override
  String toString() => 'Epub(isAvailable: $isAvailable)';
}

class SearchInfo {
  final String textSnippet;

  SearchInfo({required this.textSnippet});

  factory SearchInfo.fromMap(Map<String, dynamic> json) => SearchInfo(
        textSnippet: json['textSnippet'],
      );

  @override
  String toString() => 'SearchInfo(textSnippet: $textSnippet)';
}
