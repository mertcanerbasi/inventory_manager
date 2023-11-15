import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'src/config/router/router.dart';
import 'src/config/router/router.routes.dart';
import 'src/config/themes/app_theme.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/app_cubit/app_cubit.dart';
import 'src/presentation/cubits/home_cubit/home_cubit.dart';
import 'src/presentation/cubits/login_cubit/login_cubit.dart';
import 'src/presentation/cubits/navigation_cubit/navigation_cubit.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:oktoast/oktoast.dart';

import 'src/presentation/cubits/splash_cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI(Environment.dev);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => getIt<AppCubit>(),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => getIt<SplashCubit>(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => getIt<NavigationCubit>(),
        ),
        BlocProvider<HomeCubit>(
            create: (context) => getIt<HomeCubit>() //..generateQrCode(),
            ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          final appCubit = BlocProvider.of<AppCubit>(context);
          return OKToast(
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Inventory Manager',
                  debugShowCheckedModeBanner: false,
                  theme: appCubit.state.isDark
                      ? AppThemes.darkTheme
                      : AppThemes.lightTheme,
                  navigatorKey: getIt<GlobalKey<NavigatorState>>(),
                  initialRoute: RouteMaps.splashViewRoute,
                  // onUnknownRoute: (settings) =>
                  //     MaterialPageRoute(builder: (_) => const UnknownPage()),
                  locale: const Locale("tr"),
                  onGenerateRoute: onGenerateRoute,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
