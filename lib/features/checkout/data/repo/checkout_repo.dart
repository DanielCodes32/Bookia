import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/checkout/data/models/govs_response/govs_response.dart';
import 'package:bookia/features/checkout/data/models/place_order_model.dart/place_order_model.dart';

class CheckoutRepo {
  static Future<GovsResponse?> getGovernorates() async {
    var response = await DioProvider.get(endpoint: Apis.governorates);
    try {
      if (response.statusCode == 200) {
        return GovsResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool?> placeOrder(PlaceOrderModel placeOrder) async {
    var response = await DioProvider.post(
      endpoint: Apis.placeorder,
      data: placeOrder.toJson(),
      headers: {"Authorization": "Bearer ${SharedPref.gettoken()}"},
    );
    try {
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
