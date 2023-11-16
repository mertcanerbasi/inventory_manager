import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../config/router/router.routes.dart';
import '../../cubits/app_cubit/app_cubit.dart';
import 'package:route_map/route_map.dart';

@RouteMap(
  fullScreenDialog: true,
)
class AppSettingsView extends HookWidget {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ListTile(
              title: const Text("Uygulama Hakkında"),
              onTap: () {
                //TODO : Uygulama Hakkında
              },
            ),
            ListTile(
              title: const Text("Gizlilik Politikası"),
              onTap: () {
                //TODO : Gizlilik Politikası
              },
            ),
            ListTile(
              title: const Text("Kullanım Koşulları"),
              onTap: () {
                //TODO : Kullanım Koşulları
              },
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return SwitchListTile.adaptive(
                  title: const Text("Karanlık Mod"),
                  value: appCubit.state.isDark,
                  thumbColor: MaterialStateProperty.all(Colors.red),
                  overlayColor: MaterialStateProperty.all(Colors.red),
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade300,
                  activeTrackColor: Colors.red.shade300,
                  onChanged: (value) {
                    appCubit.changeTheme();
                  },
                );
              },
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return ListTile(
                  title: const Text("Çıkış Yap"),
                  onTap: () async {
                    await appCubit.logout();
                    LoginViewRoute()
                        .pushAndRemoveUntil(context, (route) => false);
                  },
                );
              },
            ),
          ],
        ));
  }
}
