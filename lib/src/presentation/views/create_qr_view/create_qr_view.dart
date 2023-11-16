// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_map/route_map.dart';
import '../../../utils/constants/font_sTYLE_constants.dart';
import '../../../utils/functions/truncate_text.dart';
import '../../cubits/create_qr_cubit/create_qr_cubit.dart';
import '../../../utils/constants/padding_constants.dart';

@RouteMap()
class CreateQrView extends HookWidget {
  const CreateQrView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final cubit = BlocProvider.of<CreateQrCubit>(context);
    TextEditingController productIdController = TextEditingController();
    useEffect(() {
      cubit.setselectedCategory(
          (cubit.categories != null && cubit.categories?.isNotEmpty == true)
              ? cubit.categories![0]
              : null);
      return null;
    }, const []);
    return Scaffold(
      floatingActionButton: BlocConsumer<CreateQrCubit, CreateQrState>(
        listener: (_, state) {
          if (state is CreateQrSuccess) {
            showToast("QR Kod Oluşturuldu");
          }
        },
        builder: (_, state) {
          if (state is CreateQrSuccess) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: PaddingConstants.symmetic10),
              onPressed: () {
                cubit.resetState();
              },
              child: const Icon(Ionicons.refresh),
            );
          } else if (state is CreateQrCreate) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: PaddingConstants.symmetic10),
              onPressed: () {
                if (cubit.selectedCategory == null ||
                    cubit.selectedRayon == null) {
                  showToast("Lütfen Kategori ve Reyon Seçiniz");
                  return;
                }
                if (formKey.currentState!.validate()) {
                  cubit.generateQrCode(
                      rayon: cubit.selectableRayons?.first.rayonname ?? "",
                      category: cubit.selectedCategory?.categoryname ?? "",
                      productId: productIdController.text);
                }
              },
              child: const Icon(Ionicons.qr_code),
            );
          } else {
            return Container();
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: PaddingConstants.symmeticHorizontal20,
          child: BlocBuilder<CreateQrCubit, CreateQrState>(
            builder: (_, state) {
              switch (state.runtimeType) {
                case CreateQrLoading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case CreateQrSuccess:
                  return _CreateQrSuccessView(state: state as CreateQrSuccess);
                case CreateQrCreate:
                  return _CreateQrCreateView(
                      cubit: cubit,
                      formKey: formKey,
                      productIdController: productIdController);
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

class _CreateQrSuccessView extends StatelessWidget {
  final CreateQrSuccess state;
  const _CreateQrSuccessView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(state.createQrViewData!.qrResponse!.data!.qrCodeLink)
      ],
    );
  }
}

class _CreateQrCreateView extends StatelessWidget {
  final CreateQrCubit cubit;
  final GlobalKey<FormState> formKey;
  final TextEditingController productIdController;

  const _CreateQrCreateView(
      {required this.cubit,
      required this.formKey,
      required this.productIdController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQrCubit, CreateQrState>(
      builder: (context, state) {
        if (cubit.categories?.isEmpty == true ||
            cubit.rayons?.isEmpty == true) {
          return Column(
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
                  "Lütfen mağazanız için\nkategorileri ve reyonları ekleyin",
                  style: FontStyleConstants.mediumText,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        } else {
          return Form(
            key: formKey,
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                SizedBox(height: 2.h),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.list_outlined,
                    ),
                    labelText: "Kategori",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  value: cubit.selectedCategory?.categoryname ?? "",
                  onChanged: (value) {
                    cubit.setselectedCategory(cubit.categories!.firstWhere(
                        (element) => element.categoryname == value));
                  },
                  dropdownColor: Colors.white,
                  elevation: 2,
                  items: cubit.categories!
                      .map((e) => DropdownMenuItem(
                            value: e.categoryname,
                            child: Text(
                              truncateText(e.categoryname ?? "", 30),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 2.h),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.shelves,
                    ),
                    labelText: "Reyon",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  dropdownColor: Colors.white,
                  elevation: 2,
                  value: cubit.selectableRayons?.first.rayonname ?? "",
                  onChanged: (value) {
                    cubit.setselectedRayon(cubit.selectableRayons!
                        .firstWhere((element) => element.rayonname == value));
                  },
                  items: cubit.selectableRayons!
                      .map((e) => DropdownMenuItem(
                            value: e.rayonname,
                            child: Text(
                              truncateText(e.rayonname ?? "", 35),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  controller: productIdController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.local_offer_outlined,
                    ),
                    labelText: "Ürün",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return "Lütfen Ürün Giriniz";
                    }
                    return null;
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
