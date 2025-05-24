import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/theme/app_theme.dart';
import 'package:flutter_fake_store/injection/injection.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Fake Store',
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
