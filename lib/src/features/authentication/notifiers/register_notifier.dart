import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/routes.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../models/app_user.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/base/failure.dart';
import '../../../services/navigation_service.dart';
import '../../../services/snackbar_service.dart';

class RegisterNotifier extends BaseChangeNotifier {
  RegisterNotifier({
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
    notifyListeners();
  }

  Future<void> registerUser({required UserParams userParams}) async {
    setState(state: AppState.loading);

    try {
      await authenticationRepository.register(
        emailAddress: userParams.emailAddress,
        password: userParams.password!,
      );

      await userRepository.createUser(userParams);

      navigationService.navigateOffNamed(Routes.verifyEmail);
    } on Failure catch (ex) {
      snackbarService.showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final registerNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => RegisterNotifier(
    authenticationRepository: ref.read(authenticationRepository),
    userRepository: ref.read(userRepository),
    navigationService: ref.read(navigationServiceProvider),
    snackbarService: ref.read(snackbarServiceProvider),
  ),
);
