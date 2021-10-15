import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class UpdateEmailNotifier extends BaseChangeNotifier {
  UpdateEmailNotifier(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> updateEmail(String emailAddress, String password) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).updateEmail(
        newEmailAddress: emailAddress,
        password: password,
      );

      _read(navigationService).navigateOffAllNamed(
        Routes.verifyEmail,
        (_) => false,
      );

      _read(snackbarService).showSuccessSnackBar(
        'Email Update Successful! Verify and Login Again',
      );
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final updateEmailNotifierProvider = ChangeNotifierProvider(
  (ref) => UpdateEmailNotifier(ref.read),
);
