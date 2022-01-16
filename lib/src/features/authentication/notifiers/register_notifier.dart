import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../models/user_params.dart';
import '../states/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier(this._read) : super(RegisterState.initial());

  final Reader _read;

  void togglePasswordVisibility() =>
      state = state.copyWith(passwordVisible: !state.passwordVisible);

  Future<void> registerUser({required UserParams userParams}) async {
    state = state.copyWith(viewState: ViewState.loading);

    try {
      await _read(authenticationRepository).register(params: userParams);

      _read(navigationService).navigateOffAllNamed(
        Routes.verifyEmail,
        (_) => false,
      );
    } on Failure catch (ex) {
      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  /// Register was pushed on to the navigation stack, so here we are just
  /// ...popping it off the stack to return to login
  void navigateToLogin() => _read(navigationService).navigateBack();
}

final registerNotifierProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>(
  (ref) => RegisterNotifier(ref.read),
);
