import '../../../core/utilities/view_state.dart';

class UpdateEmailState {
  final ViewState viewState;
  final bool passwordVisible;

  const UpdateEmailState._({
    required this.viewState,
    required this.passwordVisible,
  });

  factory UpdateEmailState.initial() => const UpdateEmailState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  UpdateEmailState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      UpdateEmailState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
