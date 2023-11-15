import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_map/route_map.dart';

import '../../../config/router/router.routes.dart';
import '../../../utils/constants/font_style_constants.dart';
import '../../../utils/constants/padding_constants.dart';
import '../../cubits/login_cubit/login_cubit.dart';

@RouteMap(name: "login")
class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController(
        text: kDebugMode ? "mertcan@koctas.com.tr" : null);
    TextEditingController passwordController =
        TextEditingController(text: kDebugMode ? "password123" : null);
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: PaddingConstants.symmetic20,
            child: BlocConsumer<LoginCubit, LoginState>(
              bloc: loginCubit,
              listener: (context, state) {
                if (state is LoginSuccess) {
                  RootViewRoute().pushAndRemoveUntil(
                    context,
                    (p0) => false,
                  );
                }
                if (state is LoginFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error?.response?.data["message"] ??
                          "Giriş başarısız"),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.runtimeType == LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Giriş Yap",
                        style: FontStyleConstants.largeTextBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Lütfen giriş yapmak için bilgilerinizi giriniz",
                        style: FontStyleConstants.extraSmallText,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Email adresinizi giriniz";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 2.h),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Şifre",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Şifrenizi giriniz";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() == true) {
                            loginCubit.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        child: const Text("Giriş Yap"),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
