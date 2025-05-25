import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/constants/image_constants.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/extensions/context_extensions.dart';
import 'package:flutter_fake_store/core/utils/theme/app_text_styles.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_state.dart';
import 'package:flutter_fake_store/presentation/widgets/custom_button.dart';
import 'package:flutter_fake_store/presentation/widgets/page_spacing.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthBloc>().add(const AuthCheckEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              PNGS.splashBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.20,
            left: 0,
            right: 0,
            child: SafeArea(
              child: PageSpacing(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: context.height(250),
                    ),
                    Image.asset(PNGS.branding),
                    SizedBox(
                      height: context.height(18),
                    ),
                    Text(
                      context.fakeStore,
                      style: AppTextStyles.urbanist28600TextBlack,
                    ),
                    SizedBox(
                      height: context.height(40),
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthUnauthenticatedState) {
                          return CustomButton(
                            text: context.login,
                            isLoading: false,
                            isExpanded: true,
                            onPressed: () {
                              context.go(AppRoutes.login);
                            },
                          );
                        } else if (state is AuthCheckLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return const SizedBox();
                      },
                      listener: (BuildContext context, AuthState state) {
                        if (state is AuthAuthenticatedState) {
                          context.go(AppRoutes.home);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
