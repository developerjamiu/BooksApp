import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/spacing.dart';
import '../notifiers/update_email_notifier.dart';

class UpdateEmailView extends StatefulWidget {
  const UpdateEmailView({Key? key}) : super(key: key);

  @override
  _UpdateEmailViewState createState() => _UpdateEmailViewState();
}

class _UpdateEmailViewState extends State<UpdateEmailView> {
  final _formKey = GlobalKey<FormState>();

  late final emailAddressController = TextEditingController();
  late final passwordController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding:
              const EdgeInsets.all(24.0) + MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacing.smallHeight(),
              Text(
                AppStrings.updateEmail,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacing.smallHeight(),
              const Divider(color: Colors.black87),
              const Spacing.bigHeight(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      hintText: AppStrings.emailAddress,
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      validator: context.validateEmailAddress,
                    ),
                    const Spacing.bigHeight(),
                    Consumer(
                      builder: (_, ScopedReader watch, __) {
                        final controller = watch(updateEmailNotifierProvider);

                        return AppTextField(
                          hintText: AppStrings.password,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.passwordVisible,
                          suffixIcon: IconButton(
                            icon: controller.passwordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: context.validatePassword,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacing.largeHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  isLoading: watch(updateEmailNotifierProvider).state.isLoading,
                  label: AppStrings.updateEmail,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(updateEmailNotifierProvider)
                          .updateEmail(
                            emailAddressController.text.trim(),
                            passwordController.text,
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
