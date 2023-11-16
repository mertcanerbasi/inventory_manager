import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
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
              trailing: const Icon(Ionicons.chevron_forward),
            ),
            ListTile(
              title: const Text("Gizlilik Politikası"),
              onTap: () {
                //TODO : Gizlilik Politikası
              },
              trailing: const Icon(Ionicons.chevron_forward),
            ),
            ListTile(
              title: const Text("Kullanım Koşulları"),
              onTap: () {
                //TODO : Kullanım Koşulları
              },
              trailing: const Icon(Ionicons.chevron_forward),
            ),
            BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                return SwitchListTile.adaptive(
                  title: const Text("Karanlık Mod"),
                  value: appCubit.state.isDark,
                  thumbColor: MaterialStateProperty.all(Colors.black),
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text("Çıkış Yap"),
                            content: const Text(
                                "Çıkış yapmak istediğinize emin misiniz?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("İptal"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await appCubit.logout();
                                  LoginViewRoute().pushAndRemoveUntil(
                                      context, (route) => false);
                                },
                                child: const Text("Çıkış Yap"),
                              ),
                            ],
                          );
                        });
                  },
                  trailing: const Icon(Ionicons.chevron_forward),
                );
              },
            ),
          ],
        ));
  }
}
