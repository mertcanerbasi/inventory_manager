// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_map/route_map.dart';
import '../../cubits/home_cubit/home_cubit.dart';
import '../../../utils/constants/padding_constants.dart';

@RouteMap()
class HomeView extends HookWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    final GlobalKey<FormState> formKeyCategory = GlobalKey<FormState>();
    final GlobalKey<FormState> formKeyReyon = GlobalKey<FormState>();
    final TextEditingController categoryNameController =
        TextEditingController();
    final TextEditingController reyonNameController = TextEditingController();
    //final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: PaddingConstants.symmeticHorizontal20,
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeSuccess) {
                showToast("Kategori eklendi",
                    backgroundColor: Colors.green,
                    position: ToastPosition.bottom);
              } else if (state is HomeFailed) {
                showToast(state.error.toString(),
                    backgroundColor: Colors.red,
                    position: ToastPosition.bottom);
              }
            },
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Kategori Ekle",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              enableDrag: true,
                              isDismissible: true,
                              builder: (dialogContext) {
                                return Padding(
                                  padding: PaddingConstants.symmetic20,
                                  child: IntrinsicHeight(
                                    child: Form(
                                      key: formKeyCategory,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          TextFormField(
                                            controller: categoryNameController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.list_outlined,
                                              ),
                                              labelText: "Kategori Adı",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return "Lütfen Kategori Giriniz";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (formKeyCategory
                                                    .currentState!
                                                    .validate()) {
                                                  homeCubit.addCategory(
                                                      categoryName:
                                                          categoryNameController
                                                              .text);
                                                  categoryNameController
                                                      .clear();
                                                  Navigator.pop(dialogContext);
                                                }
                                              },
                                              child: const Text("Ekle"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Reyon Ekle",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              enableDrag: true,
                              isDismissible: true,
                              builder: (dialogContext) {
                                return Padding(
                                  padding: PaddingConstants.symmetic20,
                                  child: IntrinsicHeight(
                                    child: Form(
                                      key: formKeyReyon,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          TextFormField(
                                            controller: reyonNameController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.shelves,
                                              ),
                                              labelText: "Reyon Adı",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return "Lütfen Reyon Giriniz";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          TextFormField(
                                            controller: categoryNameController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(
                                                Icons.list_outlined,
                                              ),
                                              labelText: "Kategori Adı",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return "Lütfen Kategori Giriniz";
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          SizedBox(
                                            width: double.maxFinite,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (formKeyReyon.currentState!
                                                    .validate()) {
                                                  homeCubit.addCategory(
                                                      categoryName:
                                                          categoryNameController
                                                              .text);
                                                  categoryNameController
                                                      .clear();
                                                  reyonNameController.clear();
                                                  Navigator.pop(dialogContext);
                                                }
                                              },
                                              child: const Text("Ekle"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
