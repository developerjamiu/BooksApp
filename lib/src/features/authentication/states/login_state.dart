import '../../../core/utilities/view_state.dart';

class LoginState {
  final ViewState viewState;
  final bool passwordVisible;

  const LoginState._({required this.viewState, required this.passwordVisible});

  factory LoginState.initial() => const LoginState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  LoginState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      LoginState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
