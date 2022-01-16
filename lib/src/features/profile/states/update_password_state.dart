import '../../../core/utilities/view_state.dart';

class UpdatePasswordState {
  final ViewState viewState;
  final bool oldPasswordVisible;
  final bool newPasswordVisible;

  const UpdatePasswordState._({
    required this.viewState,
    required this.oldPasswordVisible,
    required this.newPasswordVisible,
  });

  factory UpdatePasswordState.initial() => const UpdatePasswordState._(
        viewState: ViewState.idle,
        oldPasswordVisible: false,
        newPasswordVisible: false,
      );

  UpdatePasswordState copyWith({
    ViewState? viewState,
    bool? oldPasswordVisible,
    bool? newPasswordVisible,
  }) =>
      UpdatePasswordState._(
        viewState: viewState ?? this.viewState,
        oldPasswordVisible: oldPasswordVisible ?? this.oldPasswordVisible,
        newPasswordVisible: newPasswordVisible ?? this.newPasswordVisible,
      );
}
