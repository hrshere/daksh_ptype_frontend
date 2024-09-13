import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'api_endpoints.dart';
import 'http_client.dart';

class CommonApiService {
  CommonApiService._privateConstructor();

  static final CommonApiService _apiServiceInstance = CommonApiService._privateConstructor();

  factory CommonApiService() {
    return _apiServiceInstance;
  }

  final HttpClient _httpClient = HttpClient();

  Future<http.Response> login(Map<dynamic, dynamic> loginReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.login, body: loginReqBody);
  }

  Future<http.Response> fetchCategories() async {
    return _httpClient.getRequest(ApiEndpoints.category);
  }
  Future<http.Response> fetchMaterials() async {
    return _httpClient.getRequest(ApiEndpoints.material);
  }
  Future<http.Response> fetchShapes() async {
    return _httpClient.getRequest(ApiEndpoints.shape);
  }
  // Future<http.Response> fetchProducts(int category) async {
  //   return _httpClient.getRequest(ApiEndpoints.products+category.toString());
  // }
  Future<http.Response> fetchProductsById(int id) async {
    return _httpClient.getRequest(ApiEndpoints.productsById+id.toString());
  }
  Future<http.Response> fetchProductsByIds(List<int> productIds) async {
    return _httpClient.getRequest('${ApiEndpoints.productsById}?ids=${productIds.join(",")}');
  }

  Future<http.Response> fetchProducts(
      String? name,
      int? shape,
      int? rating,
      int? material,
      int? category,
      ) async {
    final parameters = <String, String>{};

    if (name != null && name.isNotEmpty) {
      parameters['search'] = Uri.encodeComponent(name);
    }
    if (shape != null && shape != 0) {
      parameters['shape__id'] = shape.toString();
    }
    if (rating != null && rating != 0) {
      parameters['rating__id'] = rating.toString();
    }
    if (material != null && material != 0) {
      parameters['material__id'] = material.toString();
    }
    if (category != null && category != 0) {
      parameters['category__id'] = category.toString();
    }


    final query = parameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    final url =
        '${ApiEndpoints.products}?$query';

    return _httpClient.getRequest(url);
  }

  Future<http.Response> placeOrder(Map<dynamic, dynamic> orderReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.orders,body: orderReqBody);
  }
  Future<http.Response> createPaymentIntent(Map<dynamic, dynamic> orderReqBody) async {
    return _httpClient.postRequest(ApiEndpoints.createPaymentIntent,body: orderReqBody);
  }
  //
  // Future<http.Response> updateContact(id,Map<dynamic, dynamic> contactReqBody) async {
  //   return _httpClient.putRequest('${ApiEndpoints.contacts}$id/',body: contactReqBody);
  // }
  //
  // Future<http.Response> deleteContact(int id) async {
  //   return _httpClient.deleteRequest('${ApiEndpoints.contacts}$id/');
  // }

// Future<http.Response> getConclusionValue(String bearerToken) async {
//   return _httpClient.getRequest(ApiEndpoints.conclusion);
// }
//
// Future<http.Response> onboarding(Map<dynamic, dynamic> onboardingReqBody) async {
//   return _httpClient.putRequest(ApiEndpoints.onboarding, body: onboardingReqBody);
// }
//
// Future<http.Response> editProfile(Map<dynamic, dynamic> profileReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.editProfile,body: profileReqBody);
// }
//
// Future<http.Response> getProfile(String bearerToken) async{
//   return _httpClient.getRequest(ApiEndpoints.getProfile);
// }
//
// Future<http.Response> getDailyConsumption(String bearerToken) async{
//   return _httpClient.getRequest(ApiEndpoints.getDailyConsumption);
// }
//
// Future<http.Response> dailyConsumption(Map<dynamic, dynamic> dailyConsumptionReqBody) async {
//   return _httpClient.postRequest(ApiEndpoints.dailyConsumption, body: dailyConsumptionReqBody);
// }
//
// Future<http.Response> generalDetail(Map<dynamic, dynamic> generalDetailReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.generalDetail,body: generalDetailReqBody);
// }
//
// Future<http.Response> remainderDetail(Map<dynamic, dynamic> remainderDetailReqBody) async {
//   return _httpClient.putRequestWithoutLoader(ApiEndpoints.remainderDetail,body: remainderDetailReqBody);
// }
//
//
//
//
// Future<http.Response> terminateAccount(Map<dynamic, dynamic> profileReqBody, id) async {
//   return _httpClient.putRequest('${ApiEndpoints.terminateAccount}$id/terminate-account',body: profileReqBody);
// }
}
