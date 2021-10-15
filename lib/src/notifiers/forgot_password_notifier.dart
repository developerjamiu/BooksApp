import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utilities/base_change_notifier.dart';
import '../repositories/authentication_repository.dart';
import '../services/base/failure.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

class ForgotPasswordController extends BaseChangeNotifier {
  ForgotPasswordController({
    required this.authenticationRepository,
    required this.snackbarService,
    required this.navigationService,
  });

  final AuthenticationRepository authenticationRepository;
  final SnackbarService snackbarService;
  final NavigationService navigationService;

  Future<void> resetPassword(String emailAddress) async {
    setState(state: AppState.loading);

    try {
      await authenticationRepository.resetPassword(emailAddress);

      navigationService.navigateBack();

      snackbarService.showSuccessSnackBar(
        'Instructions to reset your password has been sent to your email',
      );
    } on Failure catch (ex) {
      navigationService.navigateBack();

      snackbarService.showErrorSnackBar(ex.message);
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final forgotPasswordNotifierProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ForgotPasswordController(
    authenticationRepository: ref.read(authenticationRepository),
    navigationService: ref.read(navigationServiceProvider),
    snackbarService: ref.read(snackbarServiceProvider),
  ),
);
