import 'package:get/get.dart';

class HomeController extends GetxController {
  final _isLoading = true.obs;

  RxBool get isLoadingRx => _isLoading;

  set isLoading(bool value) => _isLoading.value = value;
}
