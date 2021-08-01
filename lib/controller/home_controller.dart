import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:victor_flutter/helpers/constants.dart';
import 'package:victor_flutter/model/pokemon.dart';
import 'package:victor_flutter/model/pokemon_detail.dart';
import 'package:victor_flutter/service/error_handler/error_handler.dart';
import 'package:victor_flutter/service/service.dart';

class HomeController extends GetxController {
  HomeController() {
    getPokemons(0);
  }
  Service service = Service();

  Pokemon pokemon = Pokemon();

  PokemonDetail pokemonDetail = PokemonDetail();

  final _offset = 0.obs;

  RxInt get offsetRx => _offset;

  set offset(int value) => _offset.value = value;

  final _isLoading = true.obs;

  RxBool get isLoadingRx => _isLoading;

  set isLoading(bool value) => _isLoading.value = value;

  Future getPokemons(int offset) async {
    isLoading = true;
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getPokemons(offset).then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is Pokemon) {
          this.pokemon = decodedResponse;
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

  Future<bool> getPokemonDetail(String url) async {
    bool result = false;
    var finalUrl = url.replaceAll(Constants.baseUrl, "");
    if (await Connectivity().checkConnectivity() != ConnectivityResult.none) {
      await service.getPokemonDetail(finalUrl).then((res) {
        var decodedResponse = res.fold((error) => error, (val) => val);
        if (decodedResponse is PokemonDetail) {
          this.pokemonDetail = decodedResponse;
          result = true;
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
    return result;
  }
}
