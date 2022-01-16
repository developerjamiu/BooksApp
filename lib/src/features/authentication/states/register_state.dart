import '../../../core/utilities/view_state.dart';

class RegisterState {
  final ViewState viewState;
  final bool passwordVisible;

  const RegisterState._({
    required this.viewState,
    required this.passwordVisible,
  });

  factory RegisterState.initial() => const RegisterState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  RegisterState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      RegisterState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
