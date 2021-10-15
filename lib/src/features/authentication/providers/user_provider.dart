import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_user.dart';

/// This is used to provider app user to all parts of the app
final userProvider = StateProvider<AppUser?>((ref) => null);
