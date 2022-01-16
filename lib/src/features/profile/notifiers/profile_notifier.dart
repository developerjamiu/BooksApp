import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/view_state.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';
import '../states/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this._read) : super(ProfileState.initial());

  final Reader _read;

  User get user => _read(authenticationRepository).currentUser!;

  Future<void> logoutUser() async {
    await _read(authenticationRepository).logout();

    _read(navigationService).navigateOffAllNamed(
      Routes.login,
      (_) => false,
    );
  }

  Future<void> deleteUser() async {
    try {
      state = state.copyWith(viewState: ViewState.loading);

      final message = await _read(authenticationRepository).deleteUser();

      _read(navigationService).navigateOffAllNamed(
        Routes.login,
        (_) => false,
      );

      _read(snackbarService).showSuccessSnackBar(message);
    } on Failure catch (f) {
      _read(snackbarService).showErrorSnackBar(f.message);
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(ref.read),
);
