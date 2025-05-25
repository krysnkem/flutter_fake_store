import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fake_store/core/routing/app_routes.dart';
import 'package:flutter_fake_store/core/utils/theme/app_theme.dart';
import 'package:flutter_fake_store/injection/injection.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/auth/auth_event.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_bloc.dart';
import 'package:flutter_fake_store/presentation/blocs/products/products_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  configureDependencies(); // Or getIt.init(), or whatever your setup function is named

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
          create: (context) => getIt<AuthBloc>()..add(const AuthCheckEvent()),
          lazy: true,
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProductsBloc>()..add(const GetAllProducts()),
          lazy: true,
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
