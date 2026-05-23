import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/authresponse/user.dart';
import 'package:bookia/features/checkout/data/models/govs_response/datum.dart';
import 'package:bookia/features/checkout/data/models/place_order_model.dart/place_order_model.dart';
import 'package:bookia/features/checkout/data/repo/checkout_repo.dart';
import 'package:bookia/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  List<Datum> governorates = [];
  final formkey = GlobalKey<FormState>();
  final address = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final govController = TextEditingController();
  Datum? selectedGovernorate;
  Future<void> getGovernorates() async {
    emit(CheckoutLoadingstate());
    var data = await CheckoutRepo.getGovernorates();
    if (data != null) {
      governorates = data.data ?? [];
      emit(GetGovernoratesSuccessstate());
    } else {
      emit(CheckoutErrorstate("Something went wrong"));
    }
  }

  Future<void> placeOrder() async {
    emit(CheckoutLoadingstate());
    var data = await CheckoutRepo.placeOrder(
      PlaceOrderModel(
        name: name.text,
        phone: phone.text,
        address: address.text,
        governorateId: selectedGovernorate?.id ?? 0,
        email: SharedPref.getuserinfo()?.email ?? "",
      ),
    );
    if (data == true) {
      emit(CheckoutSuccessstate());
    } else {
      emit(CheckoutErrorstate("Something went wrong"));
    }
  }
}
