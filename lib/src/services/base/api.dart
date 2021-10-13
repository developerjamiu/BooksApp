import 'api_credentials.dart';

class API {
  final String authCredential;
  final String host;

  API()
      : authCredential = APICredentials.apiKey,
        host = 'www.googleapis.com';

  static const String scheme = 'https';

  Uri baseUri() => Uri(scheme: scheme, host: host, path: '');

  Uri errorUri() => Uri(scheme: scheme, host: host, path: '/nopath');

  Uri fetchBooks({String? query}) => Uri(
        scheme: scheme,
        host: host,
        path: 'books/v1/volumes',
        query: query,
      );
}
