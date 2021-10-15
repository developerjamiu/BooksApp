import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/routes.dart';
import '../core/utilities/base_change_notifier.dart';
import '../models/app_user.dart';
import '../repositories/authentication_repository.dart';
import '../repositories/user_repository.dart';
import '../services/base/failure.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

class LoginNotifier extends BaseChangeNotifier {
  LoginNotifier({
    required this.authenticationRepository,
    required this.snackbarService,
    required this.navigationService,
    required this.userRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final SnackbarService snackbarService;
  final NavigationService navigationService;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    setState(state: AppState.loading);

    try {
      await authenticationRepository.login(
        emailAddress: emailAddress.trim(),
        password: password,
      );

      navigationService.navigateOffNamed(Routes.books);
    } on Failure catch (ex) {
      snackbarService.showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> loginUserWithGoogle() async {
    try {
      final user = await authenticationRepository.loginWithGoogle();

      if (user != null) {
        await userRepository.createUserWithGoogle(
          UserParams(
            fullName: user.displayName!,
            emailAddress: user.email!,
          ),
        );
        navigationService.navigateOffNamed(Routes.books);
      }
    } on Failure catch (ex) {
      snackbarService.showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final loginNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => LoginNotifier(
    authenticationRepository: ref.read(authenticationRepository),
    snackbarService: ref.read(snackbarServiceProvider),
    navigationService: ref.read(navigationServiceProvider),
    userRepository: ref.read(userRepository),
  ),
);
