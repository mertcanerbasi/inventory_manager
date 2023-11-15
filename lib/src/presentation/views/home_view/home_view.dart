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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeCubit.generateQrCode();
          //appCubit.changeTheme();
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: PaddingConstants.symmeticHorizontal20,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (_, state) {
              switch (state.runtimeType) {
                case HomeLoading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case HomeSuccess:
                  return _HomeSuccessView(state: state as HomeSuccess);
                case HomeCreate:
                  return _HomeCreateView(state as HomeCreate);
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _HomeSuccessView extends StatelessWidget {
  final HomeSuccess state;
  const _HomeSuccessView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Image.asset(state.homeViewData!.qrResponse!.data!.qrCodeLink)],
    );
  }
}

Widget _HomeCreateView(HomeCreate state) {
  return ListView(
    physics: const ClampingScrollPhysics(),
  );
}
