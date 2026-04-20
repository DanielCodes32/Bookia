import 'package:bookia/features/home/data/repository/home_repo.dart';
import 'package:bookia/features/home/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/models/best_seller_response/product.dart';
import 'package:bookia/features/home/models/sliders_response/slider.dart';
import 'package:bookia/features/home/models/sliders_response/sliders_response.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Slider> sliders = [];
  List<Product> bestsellers = [];
  Future<void> getInitData() async {
    emit(HomeLoadingState());
    var results = await Future.wait([
      HomeRepo.getsliders(),
      HomeRepo.getBestSellers(),
    ]);
    var slidersresponse = results[0] as SlidersResponse?;
    var bestsellersresponse = results[1] as BestSellerResponse?;
    if (slidersresponse != null || bestsellersresponse != null) {
      sliders = slidersresponse?.data?.sliders ?? [];
      bestsellers = bestsellersresponse?.data?.products ?? [];
      emit(HomeSuccessState());
    } else {
      emit(HomeErrorState());
    }
  }
}
