import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class UpdateProfileNotifier extends BaseChangeNotifier {
  UpdateProfileNotifier(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> updateProfile(String fullName) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepository).updateUser(fullName: fullName);

      _read(navigationService).navigateBack();

      _read(snackbarService).showSuccessSnackBar('Profile Update Successful');
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final updateProfileNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => UpdateProfileNotifier(ref.read),
);
