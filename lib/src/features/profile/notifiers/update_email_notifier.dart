import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../states/update_email_state.dart';

class UpdateEmailNotifier extends StateNotifier<UpdateEmailState> {
  UpdateEmailNotifier(this._read) : super(UpdateEmailState.initial());

  final Reader _read;

  void togglePasswordVisibility() =>
      state = state.copyWith(passwordVisible: !state.passwordVisible);

  Future<void> updateEmail(String emailAddress, String password) async {
    state = state.copyWith(viewState: ViewState.loading);

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
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final updateEmailNotifierProvider =
    StateNotifierProvider.autoDispose<UpdateEmailNotifier, UpdateEmailState>(
  (ref) => UpdateEmailNotifier(ref.read),
);
