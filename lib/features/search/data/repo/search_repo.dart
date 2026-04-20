import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/features/search/data/models/search_response/search_response.dart';

class SearchRepo {
  Future<SearchResponse?> search(String name) async {
    var response = await DioProvider.get(
      endpoint: Apis.search,
      queryParameters: {name: name},
    );
    try {
      if (response.statusCode == 200) {
        return SearchResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (err) {
      print(err.toString());
      return null;
    }
  }
}
