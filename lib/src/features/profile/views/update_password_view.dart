import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utilities/view_state.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/spacing.dart';
import '../notifiers/update_password_notifier.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({Key? key}) : super(key: key);

  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final oldPasswordController = TextEditingController();
  late final newPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
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
                AppStrings.updatePassword,
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
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final updatePasswordState =
                            ref.watch(updatePasswordNotifierProvider);

                        return AppTextField(
                          hintText: AppStrings.oldPassword,
                          keyboardType: TextInputType.visiblePassword,
                          controller: oldPasswordController,
                          obscureText: !updatePasswordState.oldPasswordVisible,
                          suffixIcon: IconButton(
                            icon: updatePasswordState.oldPasswordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: ref
                                .read(updatePasswordNotifierProvider.notifier)
                                .toggleOldPasswordVisibility,
                          ),
                          validator: context.validatePassword,
                        );
                      },
                    ),
                    const Spacing.bigHeight(),
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final newPasswordState =
                            ref.watch(updatePasswordNotifierProvider);

                        return AppTextField(
                          hintText: AppStrings.newPassword,
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !newPasswordState.newPasswordVisible,
                          suffixIcon: IconButton(
                            icon: newPasswordState.newPasswordVisible
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: ref
                                .read(updatePasswordNotifierProvider.notifier)
                                .toggleNewPasswordVisibility,
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
                builder: (_, ref, __) => AppElevatedButton(
                  isLoading: ref
                      .watch(updatePasswordNotifierProvider)
                      .viewState
                      .isLoading,
                  label: AppStrings.updatePassword,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(updatePasswordNotifierProvider.notifier)
                          .updatePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
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
