// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_map/route_map.dart';

import '../../../config/router/router.routes.dart';
import '../../cubits/splash_cubit/splash_cubit.dart';

@RouteMap(name: "splash")
class SplashView extends HookWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final splashCubit = BlocProvider.of<SplashCubit>(context);
    useEffect(() {
      splashCubit.checkUser().then((value) {
        if (value == true) {
          RootViewRoute().pushAndRemoveUntil(context, (route) => false);
        } else {
          LoginViewRoute().pushAndRemoveUntil(context, (route) => false);
        }
      });

      return null;
    }, const []);
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
