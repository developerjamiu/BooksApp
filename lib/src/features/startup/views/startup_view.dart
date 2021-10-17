import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/views/login_view.dart';
import '../../home/views/home_view.dart';
import '../notifiers/startup_notifier.dart';

class StartupView extends ConsumerWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (watch(startupNotifierProvider).currentUser == null) {
      return LoginView();
    } else {
      return const HomeView();
    }
  }
}
