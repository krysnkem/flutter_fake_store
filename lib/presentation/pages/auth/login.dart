import 'package:flutter/material.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/core/utils/validators/form_validators.dart';
import 'package:flutter_fake_store/presentation/widgets/custom_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageSpacing(
        child: Form(
            child: Column(
          children: [
            Text(
              context.welcomeBack,
              style: AppTextStyles.urbanist30700DarkNavy,
            ),
            SizedBox(
              height: context.height(32),
            ), // Add some spacing
            TextFormField(
              decoration: InputDecoration(hintText: context.enterYourUsername),
              validator: FormValidators.validateUsername,
            ),
            SizedBox(
              height: context.height(16),
            ),
            const PasswordFormField(),
            SizedBox(
              height: context.height(32),
            ),
            CustomButton(
              onPressed: () {
                // Handle login logic
              },
              text: context.login,
            ),
          ],
        )),
      ),
    );
  }
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    this.controller,
  });
  final TextEditingController? controller;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: context.enterYourPassword,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscured
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
      obscureText: _isObscured,
      validator: FormValidators.validatePassword,
    );
  }
}
