// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_map/route_map.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import '../../../utils/constants/padding_constants.dart';

@RouteMap()
class HomeView extends HookWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    //final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingConstants.symmeticHorizontal20,
          child: const Center(child: Text("Home View")),
        ),
      ),
    );
  }
}
