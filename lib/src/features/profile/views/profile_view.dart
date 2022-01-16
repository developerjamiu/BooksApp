import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../widgets/responsive_dialog.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../notifiers/profile_notifier.dart';
import 'update_email_view.dart';
import 'update_password_view.dart';
import 'update_profile_view.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileNotifierProvider.notifier).user;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Statusbar(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 767,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      child: const Text(AppStrings.editProfile),
                      style: ElevatedButton.styleFrom(
                        primary: colorScheme.secondary,
                        minimumSize: const Size(140, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => ResponsiveDialog(
                          child: UpdateProfileView(user: user),
                        ),
                      ),
                    ),
                    const Spacing.bigHeight(),
                    const Divider(),
                    const Spacing.bigHeight(),
                    ListTile(
                      title: Text(
                        AppStrings.changePassword,
                        style: textTheme.bodyText1,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => const ResponsiveDialog(
                          child: UpdatePasswordView(),
                        ),
                      ),
                    ),
                    const Spacing.bigHeight(),
                    ListTile(
                      title: Text(AppStrings.changeEmail,
                          style: textTheme.bodyText1),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => const ResponsiveDialog(
                          child: UpdateEmailView(),
                        ),
                      ),
                    ),
                    const Spacing.largeHeight(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text(AppStrings.logout),
                          style: ElevatedButton.styleFrom(
                            primary: colorScheme.secondary,
                            minimumSize: const Size(140, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: ref
                              .read(profileNotifierProvider.notifier)
                              .logoutUser,
                        ),
                        const Spacing.mediumWidth(),
                        ElevatedButton(
                          child: const Text(AppStrings.deleteAccount),
                          style: ElevatedButton.styleFrom(
                            primary: colorScheme.secondary,
                            minimumSize: const Size(140, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: ref
                              .read(profileNotifierProvider.notifier)
                              .deleteUser,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
