import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';

class VerifyEmailNotifier extends BaseChangeNotifier {
  VerifyEmailNotifier(this._read);

  final Reader _read;

  Future<void> navigateToLogin() async {
    await _read(authenticationRepository).logout();

    _read(navigationService).navigateOffNamed(Routes.login);
  }
}

final verifyEmailNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => VerifyEmailNotifier(ref.read),
);
