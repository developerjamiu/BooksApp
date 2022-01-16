import '../../../core/utilities/view_state.dart';

class ProfileState {
  final ViewState viewState;

  const ProfileState._({required this.viewState});

  factory ProfileState.initial() => const ProfileState._(
        viewState: ViewState.idle,
      );

  ProfileState copyWith({ViewState? viewState}) =>
      ProfileState._(viewState: viewState ?? this.viewState);
}
