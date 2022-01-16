import '../../../core/utilities/view_state.dart';

class UpdateProfileState {
  final ViewState viewState;
  final bool passwordVisible;

  const UpdateProfileState._({
    required this.viewState,
    required this.passwordVisible,
  });

  factory UpdateProfileState.initial() => const UpdateProfileState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  UpdateProfileState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      UpdateProfileState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
