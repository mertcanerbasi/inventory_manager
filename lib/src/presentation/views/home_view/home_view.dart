// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_map/route_map.dart';
import '../../../utils/constants/font_sTYLE_constants.dart';
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
    final TabController tabController = useTabController(initialLength: 2);

    //final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      appBar: TabBar(
        controller: tabController,
        tabs: const [
          Tab(
            text: "Kategoriler",
          ),
          Tab(
            text: "Reyonlar",
          ),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          children: [
            _CategoriesView(
              homeCubit: homeCubit,
              formKeyCategory: formKeyCategory,
              categoryNameController: categoryNameController,
            ),
            _RayonView(
              homeCubit: homeCubit,
              formKeyCategory: formKeyCategory,
              formKeyReyon: formKeyReyon,
              categoryNameController: categoryNameController,
              reyonNameController: reyonNameController,
            ),
          ],
        ),
      ),
    );
  }
}

class _AllView extends StatelessWidget {
  final HomeCubit homeCubit;
  final GlobalKey<FormState> formKeyCategory;
  final GlobalKey<FormState> formKeyReyon;
  final TextEditingController categoryNameController;
  final TextEditingController reyonNameController;

  const _AllView(
      {required this.homeCubit,
      required this.formKeyReyon,
      required this.formKeyCategory,
      required this.categoryNameController,
      required this.reyonNameController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmeticHorizontal20,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            showToast("Kategori eklendi",
                backgroundColor: Colors.green, position: ToastPosition.bottom);
          } else if (state is HomeFailed) {
            showToast(state.error.toString(),
                backgroundColor: Colors.red, position: ToastPosition.bottom);
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
                ExpansionTile(
                  title: Text(
                    "Kategorilerim",
                    style: FontStyleConstants.mediumText,
                  ),
                  children: homeCubit.getCategoriesResponse!.data!.categories!
                      .map((e) => ListTile(
                            leading: const Icon(
                              Icons.list_outlined,
                              color: Colors.red,
                            ),
                            title: Text(
                              e.categoryname!,
                              style: FontStyleConstants.smallText,
                            ),
                          ))
                      .toList()
                    ..add(
                      ListTile(
                        leading: const Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        title: Text("Kategori Ekle",
                            style: FontStyleConstants.smallText.copyWith(
                              color: Colors.red,
                            )),
                        onTap: () {
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
                                            onPressed: () async {
                                              if (formKeyCategory.currentState!
                                                  .validate()) {
                                                await homeCubit.addCategory(
                                                    categoryName:
                                                        categoryNameController
                                                            .text);
                                                categoryNameController.clear();
                                                await homeCubit.getCategories();
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
                      ),
                    ),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                                              categoryNameController.clear();
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
    );
  }
}

class _CategoriesView extends StatelessWidget {
  final HomeCubit homeCubit;
  final GlobalKey<FormState> formKeyCategory;
  final TextEditingController categoryNameController;

  const _CategoriesView({
    required this.homeCubit,
    required this.formKeyCategory,
    required this.categoryNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PaddingConstants.symmeticHorizontal20,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            showToast("Kategori eklendi",
                backgroundColor: Colors.green, position: ToastPosition.bottom);
          } else if (state is HomeFailed) {
            showToast(state.error.toString(),
                backgroundColor: Colors.red, position: ToastPosition.bottom);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: PaddingConstants.symmeticVertical10,
              child: Column(
                children: [
                  homeCubit.getCategoriesResponse?.data?.categories?.isEmpty ==
                          true
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Image.asset(
                                "assets/images/box.png",
                                height: 20.h,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Center(
                                child: Text(
                                  "Lütfen mağazanız için\nkategorileri ekleyin",
                                  style: FontStyleConstants.mediumText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 60.h,
                          child: GridView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: homeCubit.getCategoriesResponse!.data!
                                .categories!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              final category = homeCubit.getCategoriesResponse!
                                  .data!.categories![index];
                              return InkWell(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text(
                                          "Yapmak istediğiniz işlemi seçiniz",
                                          textAlign: TextAlign.center,
                                          style: FontStyleConstants.mediumText,
                                        ),
                                        content: IntrinsicHeight(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await homeCubit
                                                      .deleteCategory(
                                                          categoryid: category
                                                              .categoryid!);
                                                  await homeCubit
                                                      .getCategories();
                                                  Navigator.pop(dialogContext);
                                                },
                                                child: const Text(
                                                    "Kategoriyi Sil"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                    color: Colors.red,
                                    child: Center(
                                      child: Text(category.categoryname!,
                                          textAlign: TextAlign.center,
                                          style: FontStyleConstants.mediumText
                                              .copyWith(
                                            color: Colors.white,
                                          )),
                                    )),
                              );
                            },
                          ),
                        ),
                  const Spacer(),
                  SizedBox(
                    height: 5.h,
                    width: double.maxFinite,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
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
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
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
                                          onPressed: () async {
                                            if (formKeyCategory.currentState!
                                                .validate()) {
                                              await homeCubit.addCategory(
                                                  categoryName:
                                                      categoryNameController
                                                          .text);
                                              categoryNameController.clear();
                                              await homeCubit.getCategories();
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
                      label: const Text("Kategori Ekle"),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class _RayonView extends StatelessWidget {
  final HomeCubit homeCubit;
  final GlobalKey<FormState> formKeyCategory;
  final GlobalKey<FormState> formKeyReyon;
  final TextEditingController categoryNameController;
  final TextEditingController reyonNameController;

  const _RayonView(
      {required this.homeCubit,
      required this.formKeyReyon,
      required this.formKeyCategory,
      required this.categoryNameController,
      required this.reyonNameController});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Reyonlar"),
    );
  }
}
