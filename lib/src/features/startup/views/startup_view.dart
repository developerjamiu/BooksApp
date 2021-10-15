import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/views/login_view.dart';
import '../../profile/views/profile_view.dart';
import '../notifiers/startup_notifier.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read(startupNotifierProvider).currentUser == null) {
      return LoginView();
    } else {
      return const ProfileView();
    }
  }
}
