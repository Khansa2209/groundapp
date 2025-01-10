import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../../resource/secure_storage.dart';
import '../app_excaptions.dart';
import 'BaseApiServices.dart';
import 'token_header.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    final token = await SecureStorage().getLocalData(key: 'token') ?? "";
    dynamic responseJson;
    log(url);
    try {
      final response = await http
          .get(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token))
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    log(url);
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url), body: jsonEncode(data))
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future postCheckEmail(String url, Map<String, dynamic> data) async {
    log(url);
    log(data["email"]);

    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response = await post(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token),
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw FetchDataException('Your internet is slow.');
      });
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      log(e.toString());
      log(e.message);
      log(e.address.toString());

      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, Map<String, dynamic> data) async {
    log(url);
    log(data.toString());

    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response = await post(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token),
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw FetchDataException('Your internet is slow.');
      });
      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      log(e.toString());
      log(e.message);
      log(e.address.toString());

      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future<dynamic> getlocationApiResponse(
      String url, Map<String, dynamic> data) async {
    log(url);

    // Construct the full URL with query parameters
    final uri = Uri.parse(url).replace(queryParameters: data);

    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response =
          await get(uri, headers: APIHeader.createAuthHeaders(token: token))
              .timeout(const Duration(seconds: 60), onTimeout: () {
        throw FetchDataException('Your internet is slow.');
      });

      responseJson = returnResponse(response);
    } on SocketException catch (e) {
      log(e.toString());
      log(e.message);
      log(e.address.toString());
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future editProfileMultiPart(data, url) async {
    dynamic responseJson;
    log("profile image ${data["selfie"]}");

    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      MultipartRequest response = http.MultipartRequest('PUT', Uri.parse(url));

      if (data["country"] != null) {
        response.fields['country'] = data['country'];
      }
      if (data["zipcode"] != null) {
        response.fields['zipcode'] = data['zipcode'];
      }
      if (data["city"] != null) {
        response.fields['city'] = data['city'];
      }

      response.headers.addAll(
        {"Accept": "application/json", 'auth-token': token},
      );

      if (data["selfie"] != null && data["selfie"] != "") {
        log("profile image ${data["selfie"]}");
        await addFileToMultipartRequest(response, "selfie", data["selfie"]);
      }

      http.Response res = await http.Response.fromStream(await response.send());

      responseJson = returnResponse(res);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    log(response.statusCode.toString());

    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.body);
        }
        return responseJson;
      case 500:
        return jsonDecode(response.body);
      case 404:
        throw response.body.toString();
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 406:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(
            'Error pccured while communicating with server '
                    'with status code' +
                response.statusCode.toString());
    }
  }

  @override
  Future deleteApiResponse(String url) async {
    log(url);
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response = await delete(
        Uri.parse(url),
        headers: APIHeader.createAuthHeaders(token: token),
      ).timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future putApiResponse(String url, data) async {
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response = await put(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token), body: data)
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  @override
  Future patchApiResponse(String url, data) async {
    log("${data}");
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      Response response = await patch(Uri.parse(url),
              headers: APIHeader.createAuthHeaders(token: token),
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 30));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  Future<void> addFileToMultipartRequest(
      http.MultipartRequest request, String fieldName, dynamic file) async {
    log("sending $file");
    var stream;
    var length;
    String filename;

    if (file is File) {
      log("sending as a file $fieldName");

      stream = http.ByteStream(Stream.castFrom(file.openRead()));
      length = await file.length();
      filename = path.basename(file.path);
    }
    if (file is XFile) {
      log("sending as a file $fieldName");

      stream = http.ByteStream(Stream.castFrom(file.openRead()));
      length = await file.length();
      filename = path.basename(file.path);
    } else {
      throw Exception('Unsupported file type');
    }

    var multipartFile = http.MultipartFile(
      fieldName,
      stream,
      length,
      filename: filename,
    );
    log("sending $fieldName to db $multipartFile");
    request.files.add(multipartFile);
  }

  @override
  Future multiPartSignUp(url, data) async {
    log("data is $data");
    log(url);
    dynamic responseJson;
    try {
      log("Creating MultipartRequest");
      MultipartRequest response = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['pId'] = data['pId'] ?? ""
        ..fields['cId'] = data['cId'] ?? ""
        ..fields['fcmToken'] = data['fcmToken'] ?? ""
        ..fields['email'] = data['email'] ?? ""
        ..fields['driverActSta'] = data['driverActSta'] ?? ""
        ..fields['password'] = data['password'] ?? ""
        ..fields['firstName'] = data['firstName'] ?? ""
        ..fields['lastName'] = data['lastName'] ?? ""
        ..fields['mobileNumber'] = data['mobileNumber'] ?? ""
        ..fields['lat'] = data['lat'] ?? ""
        ..fields['lng'] = data['lng'] ?? "";
      // ..fields['hobbies'] = data['hobbies'] ?? ""
      // ..fields['music'] = data['music'] ?? "";

      // Check if the image exists and is not empty
      if (data["image"] != null && data["image"].isNotEmpty) {
        log("Image is present, adding to request");
        for (var file in data["image"]) {
          await addFileToMultipartRequest(response, "image", file);
        }
      } else {
        log("No image provided, skipping image upload");
      }

      response.headers.addAll(
        {"Accept": "application/json"},
      );

      http.Response res = await http.Response.fromStream(await response.send());

      responseJson = returnResponse(res);
    } catch (e, c) {
      // Generic catch block for any other types of exceptions that might occur

      log('An unexpected error occurred: $e');
      log('stacl trace: $c');

      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }

  @override
  Future multiPartVehicle(url, data) async {
    log("data is $data");
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      log(token);

      MultipartRequest response = http.MultipartRequest('POST', Uri.parse(url))
        ..fields['make'] = data['make']
        ..fields['model'] = data['model']
        ..fields['year'] = data['year']
        ..fields['color'] = data['color']
        ..fields['vin'] = data['vin']
        ..fields['name'] = data['name']
        ..fields['seats'] = data['seat']
        ..fields['vehicleInsurer'] = data['insurance']
        ..fields['insurancePolicyNumber'] = data['insurancePolicy']
        ..fields['insuranceExpDate'] = data['insuranceExp']
        ..fields['vehicleRegstate'] = data['vehicleRegstate'];

      if (data["media"].isNotEmpty) {
        for (var file in data["media"]) {
          await addFileToMultipartRequest(response, "media", file);
        }
      }
      if (data["insuranceCardImage"] != null) {
        var stream;
        var length;
        String filename;

        stream = http.ByteStream(
            Stream.castFrom(data["insuranceCardImage"].openRead()));
        length = await data["insuranceCardImage"].length();
        filename = path.basename(data["insuranceCardImage"].path);
        var multipartFile = http.MultipartFile(
          "insuranceCardImage",
          stream,
          length,
          filename: filename,
        );
        log("sending image to db $multipartFile");
        response.files.add(multipartFile);
      }

      log("response ${response}");
      response.headers.addAll(
        {"Accept": "application/json", 'auth-token': token},
      );

      http.Response res = await http.Response.fromStream(await response.send());

      responseJson = returnResponse(res);
    } catch (e) {
      // Generic catch block for any other types of exceptions that might occur
      log('An unexpected error occurred: $e');
      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }

  @override
  Future multiPartProfileEdit(url, data) async {
    log("data is $data");
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";
      log(token);

      MultipartRequest response = http.MultipartRequest('Post', Uri.parse(url));
      if (data.containsKey('firstName')) {
        response.fields['firstName'] = data['firstName'];
      }
      if (data.containsKey('email')) {
        response.fields['email'] = data['email'];
      }
      if (data.containsKey('lastName')) {
        response.fields['lastName'] = data['lastName'];
      }
      if (data.containsKey('hobbies')) {
        response.fields['hobbies'] = json.encode(data["hobbies"]);
      }
      if (data.containsKey('music')) {
        response.fields['music'] = json.encode(data["music"]);
      }

      if (data["image"] != null) {
        var stream;
        var length;
        String filename;

        stream = http.ByteStream(Stream.castFrom(data["image"].openRead()));
        length = await data["image"].length();
        filename = path.basename(data["image"].path);
        var multipartFile = http.MultipartFile(
          "image",
          stream,
          length,
          filename: filename,
        );
        log("sending image to db $multipartFile");
        response.files.add(multipartFile);
      }

      log("response ${response}");
      response.headers.addAll(
        {"Accept": "application/json", 'auth-token': token},
      );

      http.Response res = await http.Response.fromStream(await response.send());

      responseJson = returnResponse(res);
    } catch (e) {
      // Generic catch block for any other types of exceptions that might occur
      log('An unexpected error occurred: $e');
      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }

  @override
  Future multiPartDriverProfileEdit(url, data) async {
    log(url);
    log("data is $data");
    dynamic responseJson;
    try {
      final token = await SecureStorage().getLocalData(key: 'token') ?? "";

      MultipartRequest response = http.MultipartRequest('Post', Uri.parse(url));

      // Add fields for basic user data
      if (data.containsKey('fcmToken')) {
        log("fcm t");
        response.fields['fcmToken'] = data['fcmToken'];
      }
      if (data.containsKey('pId')) {
        response.fields['pId'] = data['pId'];
      }
      if (data.containsKey('cId')) {
        response.fields['cId'] = data['cId'];
      }
      if (data.containsKey('lat')) {
        response.fields['lat'] = data['lat'];
      }
      if (data.containsKey('lng')) {
        response.fields['lng'] = data['lng'];
      }
      if (data.containsKey('firstName')) {
        response.fields['firstName'] = data['firstName'];
      }
      if (data.containsKey('email')) {
        response.fields['email'] = data['email'];
      }
      if (data.containsKey('lastName')) {
        response.fields['lastName'] = data['lastName'];
      }
      if (data.containsKey('gender')) {
        response.fields['gender'] = data['gender'];
      }
      if (data.containsKey('dob')) {
        response.fields['dob'] = data['dob'];
      }
      if (data.containsKey('address')) {
        response.fields['address'] = data['address'];
      }
      if (data.containsKey('licenseExpDate')) {
        response.fields['licenseExpDate'] = data['licenseExpDate'];
      }
      if (data.containsKey('licenseNumber')) {
        response.fields['licenseNumber'] = data['licenseNumber'];
      }
      if (data.containsKey('licenseState')) {
        response.fields['licenseState'] = data['licenseState'];
      }
      if (data.containsKey('hobbies')) {
        response.fields['hobbies'] = json.encode(data['hobbies']);
      }
      if (data.containsKey('music')) {
        response.fields['music'] = json.encode(data['music']);
      }

      // Handle image fields (driver's image, license images, etc.)
      if (data['image'] != null) {
        var stream = http.ByteStream(Stream.castFrom(data['image'].openRead()));
        var length = await data['image'].length();
        var filename = path.basename(data['image'].path);
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: filename,
        );
        response.files.add(multipartFile);
      }

      if (data['licenseImageFront'] != null) {
        var stream = http.ByteStream(
            Stream.castFrom(data['licenseImageFront'].openRead()));
        var length = await data['licenseImageFront'].length();
        var filename = path.basename(data['licenseImageFront'].path);
        var multipartFile = http.MultipartFile(
          'licenseImageFront',
          stream,
          length,
          filename: filename,
        );
        response.files.add(multipartFile);
      }

      if (data['licenseImageBack'] != null) {
        var stream = http.ByteStream(
            Stream.castFrom(data['licenseImageBack'].openRead()));
        var length = await data['licenseImageBack'].length();
        var filename = path.basename(data['licenseImageBack'].path);
        var multipartFile = http.MultipartFile(
          'licenseImageBack',
          stream,
          length,
          filename: filename,
        );
        response.files.add(multipartFile);
      }

      // Adding headers and making request
      response.headers.addAll({
        "Accept": "application/json",
        'auth-token': token,
      });

      http.Response res = await http.Response.fromStream(await response.send());
      responseJson = returnResponse(res);
    } catch (e) {
      log('An unexpected error occurred: $e');
      throw FetchDataException('An unexpected error occurred');
    }
    return responseJson;
  }
}
