import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../notifiers/profile_notifier.dart';
import 'update_email_view.dart';
import 'update_password_view.dart';
import 'update_profile_view.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(profileNotifierProvider).user;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Statusbar(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacing.height(72),
                CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  radius: 36,
                  child: Text(
                    user.displayName![0],
                    style: textTheme.headline6?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                const Spacing.bigHeight(),
                Text(
                  user.displayName!,
                  style: textTheme.headline6,
                ),
                const Spacing.tinyHeight(),
                Text(user.email!),
                const Spacing.mediumHeight(),
                ElevatedButton(
                  child: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    primary: colorScheme.secondary,
                    minimumSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => UpdateProfileView(user: user),
                  ),
                ),
                const Spacing.bigHeight(),
                const Divider(),
                const Spacing.bigHeight(),
                ListTile(
                  title: Text('Change Password', style: textTheme.bodyText1),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => const UpdatePasswordView(),
                  ),
                ),
                const Spacing.bigHeight(),
                ListTile(
                  title: Text('Change Email', style: textTheme.bodyText1),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => const UpdateEmailView(),
                  ),
                ),
                const Spacing.largeHeight(),
                ElevatedButton(
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    primary: colorScheme.secondary,
                    minimumSize: const Size(140, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: context.read(profileNotifierProvider).logoutUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
