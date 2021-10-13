import 'package:http/http.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../base/api.dart';
import 'http_service.dart';

abstract class INetworkService {
  API get getAPI;

  Future<dynamic> get(Uri uri);
}

final networkService = Provider<INetworkService>(
  (ref) => HttpService(client: Client()),
);
