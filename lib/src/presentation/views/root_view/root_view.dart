import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_map/route_map.dart';

import '../../../config/router/router.routes.dart';
import '../../../utils/constants/app_strings.dart';
import '../../cubits/navigation_cubit/navigation_cubit.dart';
import '../create_qr_view/create_qr_view.dart';
import '../home_view/home_view.dart';
import '../../../utils/enums/navigation_bar_item.dart';
import 'package:ionicons/ionicons.dart';

@RouteMap(name: "/")
class RootView extends HookWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationCubit = BlocProvider.of<NavigationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(AppStrings.appName,
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              AppSettingsViewRoute().push(context);
            },
            icon: const Icon(Ionicons.settings),
          ),
        ],
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state.navBarItem == NavBarItem.settings) {
            // return Container(
            //   color: Colors.red,
            // );
            return const HomeView();
          } else if (state.navBarItem == NavBarItem.read) {
            //TODO : QR Code Reader
            return Container(
              color: Colors.green,
            );
          } else {
            return const CreateQrView();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: state.pageIndex,
            onTap: (index) {
              navigationCubit.setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.storefront),
                label: "Mağaza Bilgileri",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: "Envanter Sayım",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.qr_code),
                label: "QR Kod Oluştur",
              ),
            ],
          );
        },
      ),
    );
  }
}
