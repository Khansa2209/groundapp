abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, Map<String, dynamic> data);

  Future<dynamic> getlocationApiResponse(String url, Map<String, dynamic> data);

  Future<dynamic> postApiResponse(String url, dynamic data);
  Future<dynamic> postCheckEmail(String url, Map<String, dynamic> data);

  Future<dynamic> putApiResponse(String url, dynamic data);
  Future<dynamic> deleteApiResponse(String url);

  Future<dynamic> patchApiResponse(String url, dynamic data);

  Future<dynamic> multiPartSignUp(String url, dynamic data);
  Future<dynamic> multiPartVehicle(String url, dynamic data);

  Future<dynamic> multiPartProfileEdit(String url, dynamic data);

  Future<dynamic> multiPartDriverProfileEdit(String url, dynamic data);

  Future<dynamic> editProfileMultiPart(
    dynamic data,
    String url,
  );
}
