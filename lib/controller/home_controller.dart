import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:victor_flutter/model/categories.dart';
import 'package:victor_flutter/model/starships.dart';
import 'package:victor_flutter/service/error_handler/error_handler.dart';
import 'package:victor_flutter/service/service.dart';

class HomeController extends GetxController {
  HomeController() {
    getCategories();
  }
  Service service = Service();

  Starships starships = Starships();

  Categories categories = Categories();

  List categoriesList = [];

  final _isLoading = true.obs;

  RxBool get isLoadingRx => _isLoading;

  set isLoading(bool value) => _isLoading.value = value;

  Future getCategories() async {
    isLoading = true;
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getCategories().then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is Categories) {
          Map<String, dynamic> categoriesMap = decodedResponse.toJson();
          categoriesMap.forEach((key, value) {
            categoriesList.add([key, value]);
          });
        } else if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;

          var msg = error.message;
        }
      }).catchError((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;
          var msg = error.message;
        }
      });
    } else {
      print("NO CONNECTION");
    }
    isLoading = false;
  }

  Future getAllStarships() async {
    isLoading = true;
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getAllStarships().then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is Starships) {
          this.starships = decodedResponse;
        } else if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;

          var msg = error.message;
        }
      }).catchError((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;
          var msg = error.message;
        }
      });
    } else {
      print("NO CONNECTION");
    }
    isLoading = false;
  }
}
