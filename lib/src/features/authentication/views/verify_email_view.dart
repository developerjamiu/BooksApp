import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/navigation_service.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Center(
              child: Card(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Books App',
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
                        'Verify your email',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const Spacing.smallHeight(),
                      Center(
                        child: Text(
                          'A verification link has been sent to your email. Please confirm that you want to use this as your account email address. Once it\'s done I\'ll be able to start assisting you.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppElevatedButton(
                        label: 'Go to Log In',
                        onPressed: () {
                          context.read(navigationService).navigateBack();
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
    );
  }
}
