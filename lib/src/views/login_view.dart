import 'package:books/src/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/routes.dart';
import '../core/utilities/base_change_notifier.dart';
import '../core/utilities/validation_extensions.dart';
import '../notifiers/login_notifier.dart';
import '../services/navigation_service.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/spacing.dart';
import '../widgets/statusbar.dart';
import 'forgot_password_view.dart';

class LoginView extends HookWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Statusbar(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacing.largeHeight(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const Spacing.largeHeight(),
                    AppTextField(
                      hintText: 'Email Address',
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      validator: context.validateEmailAddress,
                    ),
                    const Spacing.bigHeight(),
                    Consumer(
                      builder: (context, watch, child) {
                        final loginNotifier = watch(loginNotifierProvider);

                        return AppTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !loginNotifier.passwordVisible,
                          suffixIcon: IconButton(
                            icon: loginNotifier.passwordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: loginNotifier.togglePasswordVisibility,
                          ),
                          validator: context.validatePassword,
                        );
                      },
                    ),
                    const Spacing.smallHeight(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => const ForgotPasswordView(),
                          );
                        },
                        child: const Text('Forgot Password'),
                      ),
                    ),
                    const Spacing.smallHeight(),
                  ],
                ),
              ),
              const Spacing.mediumHeight(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Consumer(
                      builder: (_, watch, __) => AppElevatedButton(
                        isLoading: watch(loginNotifierProvider).state.isLoading,
                        label: 'Login',
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          if (_formKey.currentState!.validate()) {
                            await context.read(loginNotifierProvider).loginUser(
                                  emailAddress: emailAddressController.text,
                                  password: passwordController.text,
                                );
                          }
                        },
                      ),
                    ),
                    const Spacing.mediumHeight(),
                    ElevatedButton.icon(
                      icon: Image.asset(AppImages.googleLogo, width: 24),
                      onPressed: () => context
                          .read(loginNotifierProvider)
                          .loginUserWithGoogle(),
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read(navigationServiceProvider)
                            .navigateToNamed(Routes.register);
                      },
                      child: const Text('No Account? Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
