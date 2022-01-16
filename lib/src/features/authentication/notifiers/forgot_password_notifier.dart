import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../states/forgot_password_state.dart';

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier(this._read) : super(ForgotPasswordState.initial());

  final Reader _read;

  Future<void> resetPassword(String emailAddress) async {
    state = state.copyWith(viewState: ViewState.loading);

    try {
      await _read(authenticationRepository).resetPassword(emailAddress.trim());

      _read(navigationService).navigateBack();

      _read(snackbarService).showSuccessSnackBar(
        'Instructions to reset your password has been sent to your email',
      );
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final forgotPasswordNotifierProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) => ForgotPasswordNotifier(ref.read),
);
