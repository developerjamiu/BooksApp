import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../states/update_profile_state.dart';

class UpdateProfileNotifier extends StateNotifier<UpdateProfileState> {
  UpdateProfileNotifier(this._read) : super(UpdateProfileState.initial());

  final Reader _read;

  void togglePasswordVisibility() =>
      state = state.copyWith(passwordVisible: !state.passwordVisible);

  Future<void> updateProfile(String fullName) async {
    state = state.copyWith(viewState: ViewState.loading);

    try {
      await _read(authenticationRepository).updateUser(fullName: fullName);

      _read(navigationService).navigateBack();

      _read(snackbarService).showSuccessSnackBar('Profile Update Successful');
    } on Failure catch (ex) {
      _read(navigationService).navigateBack();

      _read(snackbarService).showErrorSnackBar(ex.message);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final updateProfileNotifierProvider = StateNotifierProvider.autoDispose<
    UpdateProfileNotifier, UpdateProfileState>(
  (ref) => UpdateProfileNotifier(ref.read),
);
