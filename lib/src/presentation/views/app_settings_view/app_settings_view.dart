import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:route_map/route_map.dart';

@RouteMap(
  fullScreenDialog: true,
)
class AppSettingsView extends HookWidget {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.red,
    );
  }
}
