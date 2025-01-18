import 'package:get/get.dart';

class AddressController extends GetxController {
  var address1 = ''.obs;
  var address2 = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var zip = ''.obs;

  void updateAddress({
    required String newAddress1,
    required String newAddress2,
    required String newCity,
    required String newState,
    required String newZip,
  }) {
    address1.value = newAddress1;
    address2.value = newAddress2;
    city.value = newCity;
    state.value = newState;
    zip.value = newZip;
  }

  void clearAddress() {
    address1.value = '';
    address2.value = '';
    city.value = '';
    state.value = '';
    zip.value = '';
  }
}
