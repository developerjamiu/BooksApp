import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/statusbar.dart';
import '../models/app_user.dart';
import '../notifiers/register_notifier.dart';

class RegisterView extends HookWidget {
  RegisterView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fullNameController = useTextEditingController();
    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Statusbar(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 767,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacing.largeHeight(),
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24),
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Spacing.largeHeight(),
                      AppTextField(
                        hintText: 'Full Name',
                        controller: fullNameController,
                        validator: context.validateFullName,
                      ),
                      const Spacing.bigHeight(),
                      AppTextField(
                        hintText: 'Email Address',
                        controller: emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        validator: context.validateEmailAddress,
                      ),
                      const Spacing.bigHeight(),
                      Consumer(
                        builder: (context, watch, child) {
                          final loginNotifier = watch(registerNotifierProvider);

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
                    ],
                  ),
                  const Spacing.mediumHeight(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Consumer(
                          builder: (_, watch, __) => AppElevatedButton(
                            isLoading:
                                watch(registerNotifierProvider).state.isLoading,
                            label: 'Create Account',
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read(registerNotifierProvider)
                                    .registerUser(
                                      userParams: UserParams(
                                        fullName: fullNameController.text,
                                        emailAddress:
                                            emailAddressController.text.trim(),
                                        password: passwordController.text,
                                      ),
                                    );
                              }
                            },
                          ),
                        ),
                        const Spacing.smallHeight(),
                        TextButton(
                          onPressed: () {
                            context
                                .read(registerNotifierProvider)
                                .navigateToLogin();
                          },
                          child: const Text('Have Account? Login'),
                        ),
                        const Spacing.smallHeight(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
