import '../../../core/utilities/view_state.dart';

class ForgotPasswordState {
  final ViewState viewState;

  const ForgotPasswordState._({required this.viewState});

  factory ForgotPasswordState.initial() => const ForgotPasswordState._(
        viewState: ViewState.idle,
      );

  ForgotPasswordState copyWith({ViewState? viewState}) =>
      ForgotPasswordState._(viewState: viewState ?? this.viewState);
}
