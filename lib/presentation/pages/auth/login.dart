import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/core/utils/validators/form_validators.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_fake_store/presentation/widgets/custom_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String get username => usernameController.text.trim();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: PageSpacing(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
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
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: context.enterYourUsername,
                  ),
                  validator: FormValidators.validateUsername,
                ),
                SizedBox(
                  height: context.height(16),
                ),
                PasswordFormField(
                  controller: passwordController,
                ),
                SizedBox(
                  height: context.height(32),
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state is AuthLoadingState,
                      onPressed: () {
                        if (Form.of(context).validate()) {
                          // Trigger login event
                          context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  username: username,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      text: context.login,
                    );
                  },
                  listener: (BuildContext context, AuthState state) {
                    if (state is AuthAuthenticatedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.loginSuccess)),
                      );
                      context.go(AppRoutes.home);
                    } else if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    } else if (state is AuthUnauthenticatedState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message ?? context.loginError),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
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
