import '../network_data/network/BaseApiServices.dart';
import '../network_data/network/NetworkApiService.dart';
import '../resource/api_endpoints.dart';

class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiEndPoints.login, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpApi(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiEndPoints.signup, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> otpVerify(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiEndPoints.verifyOtp, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
