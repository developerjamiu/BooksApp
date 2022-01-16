import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';

class VerifyEmailNotifier extends StateNotifier<void> {
  VerifyEmailNotifier(this._read) : super(null);

  final Reader _read;

  Future<void> navigateToLogin() async {
    await _read(authenticationRepository).logout();

    _read(navigationService).navigateOffNamed(Routes.login);
  }
}

final verifyEmailNotifierProvider =
    StateNotifierProvider.autoDispose<VerifyEmailNotifier, void>(
  (ref) => VerifyEmailNotifier(ref.read),
);
