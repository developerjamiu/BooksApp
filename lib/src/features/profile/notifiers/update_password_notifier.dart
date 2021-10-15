import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class UpdatePasswordNotifier extends BaseChangeNotifier {
  UpdatePasswordNotifier(this._read);

  final Reader _read;

  bool _oldPasswordVisible = false;

  bool get oldPasswordVisible => _oldPasswordVisible;

  void toggleOldPasswordVisibility() {
    _oldPasswordVisible = !_oldPasswordVisible;
    setState();
  }

  bool _newPasswordVisible = false;

  bool get newPasswordVisible => _newPasswordVisible;

  void toggleNewPasswordVisibility() {
    _newPasswordVisible = !_newPasswordVisible;
    setState();
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      _read(navigationService).navigateBack();

      _read(snackbarService).showSuccessSnackBar('Password Update Successful');
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final updatePasswordNotifierProvider = ChangeNotifierProvider(
  (ref) => UpdatePasswordNotifier(ref.read),
);
