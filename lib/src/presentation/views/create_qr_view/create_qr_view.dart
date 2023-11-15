// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:route_map/route_map.dart';
import '../../cubits/create_qr_cubit/create_qr_cubit.dart';
import '../../../utils/constants/padding_constants.dart';

@RouteMap()
class CreateQrView extends HookWidget {
  const CreateQrView({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final cubit = BlocProvider.of<CreateQrCubit>(context);
    TextEditingController reyonController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController productIdController = TextEditingController();
    //final appCubit = BlocProvider.of<AppCubit>(context);
    return Scaffold(
      floatingActionButton: BlocConsumer<CreateQrCubit, CreateQrState>(
        listener: (_, state) {
          if (state is CreateQrSuccess) {
            showToast("QR Code Oluşturuldu");
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
                if (formKey.currentState!.validate()) {
                  cubit.generateQrCode(
                      rayon: reyonController.text,
                      category: categoryController.text,
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
                  return _HomeSuccessView(state: state as CreateQrSuccess);
                case CreateQrCreate:
                  return _HomeCreateView(
                      state: state as CreateQrCreate,
                      formKey: formKey,
                      reyonController: reyonController,
                      categoryController: categoryController,
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

class _HomeSuccessView extends StatelessWidget {
  final CreateQrSuccess state;
  const _HomeSuccessView({required this.state});

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

Widget _HomeCreateView(
    {required CreateQrCreate state,
    required GlobalKey<FormState> formKey,
    required TextEditingController reyonController,
    required TextEditingController categoryController,
    required TextEditingController productIdController}) {
  return Form(
    key: formKey,
    child: ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(height: 2.h),
        TextFormField(
          controller: reyonController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.shelves,
            ),
            labelText: "Reyon",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (value) {
            if (value?.isEmpty == true) {
              return "Lütfen Reyon Giriniz";
            }
            return null;
          },
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: categoryController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.list_outlined,
            ),
            labelText: "Kategori",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          validator: (value) {
            if (value?.isEmpty == true) {
              return "Lütfen Kategori Giriniz";
            }
            return null;
          },
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
