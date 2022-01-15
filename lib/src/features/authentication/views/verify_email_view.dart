import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../notifiers/verify_email_notifier.dart';

class VerifyEmailView extends ConsumerWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Center(
              child: SizedBox(
                width: 500,
                child: Card(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppStrings.appName,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const Spacing.mediumHeight(),
                        Icon(
                          Icons.mail,
                          size: 36,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Spacing.bigHeight(),
                        Text(
                          AppStrings.verifyMail,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacing.smallHeight(),
                        Center(
                          child: Text(
                            AppStrings.verifyMailText,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppElevatedButton(
                          label: AppStrings.goToLogin,
                          onPressed: () async {
                            await ref
                                .read(verifyEmailNotifierProvider)
                                .navigateToLogin();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
