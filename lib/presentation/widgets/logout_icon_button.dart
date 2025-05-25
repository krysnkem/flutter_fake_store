import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/utils/dialog/dialogs.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_colors.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({super.key, this.onLogout});
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return LogoutIconWidget(
      onLogout: () async {
        final shouldLogout = await Dialogs.showLogout(context);
        if (shouldLogout) {
          authBloc.add(const AuthLogoutEvent());
          onLogout?.call();
        }
      },
    );
  }
}

class LogoutIconWidget extends StatelessWidget {
  const LogoutIconWidget({
    super.key,
    required this.onLogout,
  });

  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onLogout?.call();
      },
      icon: Column(
        children: [
          Ink(
            padding: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
              color: AppColors.accentYellow,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.logout),
          ),
          Text(
            context.logOut,
            style: AppTextStyles.urbanist12700TextGrey80,
          ),
        ],
      ),
    );
  }
}
