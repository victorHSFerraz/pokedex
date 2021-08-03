import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:victor_flutter/helpers/constants.dart';
import 'package:victor_flutter/model/location.dart';
import 'package:victor_flutter/model/location_detail.dart';
import 'package:victor_flutter/model/location_info.dart';
import 'package:victor_flutter/service/error_handler/error_handler.dart';
import 'package:victor_flutter/service/service.dart';

class LocationController extends GetxController {
  LocationController() {
    getLocations(0);
  }
  Service service = Service();

  Location location = Location();

  LocationDetail locationDetail = LocationDetail();

  LocationInfo locationInfo = LocationInfo();

  final _offset = 0.obs;

  RxInt get offsetRx => _offset;

  set offset(int value) => _offset.value = value;

  final _isLoading = true.obs;

  RxBool get isLoadingRx => _isLoading;

  set isLoading(bool value) => _isLoading.value = value;

  Future getLocations(int offset) async {
    isLoading = true;
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getLocations(offset).then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is Location) {
          this.location = decodedResponse;
          var newOffset = 100;
          offsetRx.value = offsetRx.value + newOffset;
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

  Future<bool> getLocationInfo(String url) async {
    bool result = false;
    var finalUrl = url.replaceAll(Constants.baseUrl, "");
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getLocationInfo(finalUrl).then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is LocationInfo) {
          this.locationInfo = decodedResponse;
          result = true;
        } else if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;
          final message = decodedResponse;
          final color = Colors.red;

          showSimpleNotification(
            Text('Oops'),
            subtitle: Text("Infelizmente essa localização não possui dados :("),
            background: color,
          );

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
    return result;
  }

  Future<bool> getLocationDetail(String url) async {
    bool result = false;
    var finalUrl = url.replaceAll(Constants.baseUrl, "");
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getLocationDetail(finalUrl).then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is LocationDetail) {
          this.locationDetail = decodedResponse;
          result = true;
        } else if (decodedResponse is ErrorHandler) {
          ErrorHandler error = decodedResponse;
          final message = decodedResponse;
          final color = Colors.red;

          showSimpleNotification(
            Text('Oops'),
            subtitle: Text("Infelizmente essa localização não possui dados :("),
            background: color,
          );

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
    return result;
  }
}
