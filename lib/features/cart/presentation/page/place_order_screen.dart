import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String? total;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  var govController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              pop(context);
            },
            child: SvgPic(assetName: AppAssets.back, width: 41, height: 41),
          ),
        ),
        body: MyBodyView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Place Your Order", style: TextStyles.title),
              Gap(10),
              Text(
                "Don't worry! It occurs. Please enter the email address linked with your account.",
                style: TextStyles.caption1,
              ),
              Gap(25),
              CustomFormField(
                hintText: "Full Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              Gap(12),
              CustomFormField(
                hintText: "Address",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
              ),
              Gap(12),
              CustomFormField(
                hintText: "Phone",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your phone number";
                  } else if (value.length != 11) {
                    return "Please enter a valid phone number";
                  }
                  return null;
                },
              ),
              Gap(12),
              CustomFormField(
                controller: govController,
                hintText: "Governorate",
                readOnly: true,
                suffixIcon: const Icon(Icons.keyboard_arrow_down),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    builder: (sheetContext) {
                      return BlocProvider.value(
                        value: context.read<CartCubit>(),
                        child: BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            var cubit = context.read<CartCubit>();
                            if (state is GetGovernoratesLoadingstate) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is GetGovernoratesErrorstate) {
                              return Center(
                                child: Text(state.message),
                              );
                            }
                            return ListView.separated(
                              padding: const EdgeInsets.all(20),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    govController.text = cubit
                                            .governorates[index]
                                            .governorateNameEn ??
                                        "";
                                    pop(context);
                                  },
                                  title: Text(
                                    cubit.governorates[index]
                                            .governorateNameEn ??
                                        "",
                                    style: TextStyles.caption1.copyWith(
                                      color: AppColors.blackColor,),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: cubit.governorates.length,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total:",
                    style: TextStyles.title.copyWith(
                      color: AppColors.darkgreycolor,
                    ),
                  ),
                  Text(
                    widget.total ?? "",
                    style: TextStyles.title.copyWith(
                      color: AppColors.darkgreycolor,
                    ),
                  ),
                ],
              ),
              MainButton(title: "Submit Order", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
