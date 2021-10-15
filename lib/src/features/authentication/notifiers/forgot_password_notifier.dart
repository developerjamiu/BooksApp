import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class ForgotPasswordController extends BaseChangeNotifier {
  ForgotPasswordController(this._read);

  final Reader _read;

  Future<void> resetPassword(String emailAddress) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).resetPassword(emailAddress);

      _read(navigationService).navigateBack();

      _read(snackbarService).showSuccessSnackBar(
        'Instructions to reset your password has been sent to your email',
      );
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final forgotPasswordNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ForgotPasswordController(ref.read),
);
