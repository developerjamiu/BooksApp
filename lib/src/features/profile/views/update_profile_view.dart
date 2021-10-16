import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/strings.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../widgets/app_elevated_button.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/spacing.dart';
import '../notifiers/update_profile_notifier.dart';

class UpdateProfileView extends StatefulWidget {
  final User user;

  const UpdateProfileView({Key? key, required this.user}) : super(key: key);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();

  late final fullNameController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.user.displayName!;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
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
                AppStrings.updateProfile,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacing.smallHeight(),
              const Divider(color: Colors.black87),
              const Spacing.bigHeight(),
              Form(
                key: _formKey,
                child: AppTextField(
                  hintText: AppStrings.fullName,
                  labelText: AppStrings.fullName,
                  controller: fullNameController,
                  validator: context.validateFullName,
                ),
              ),
              const Spacing.largeHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  isLoading:
                      watch(updateProfileNotifierProvider).state.isLoading,
                  label: AppStrings.updateProfile,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(updateProfileNotifierProvider)
                          .updateProfile(fullNameController.text);
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
