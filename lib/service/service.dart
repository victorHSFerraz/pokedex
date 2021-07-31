import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:victor_flutter/helpers/constants.dart';
import 'package:victor_flutter/model/pokemon.dart';
import 'package:victor_flutter/model/pokemon_detail.dart';

import 'error_handler/error_handler.dart';

class Service {
  Dio dio = new Dio(
    new BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: Constants.connectTimeout,
      receiveTimeout: Constants.receiveTimeout,
      validateStatus: (status) {
        return status <= 500;
      },
    ),
  );

  Future<Either<ErrorHandler, Pokemon>> getPokemons() async {
    try {
      Response response = await dio.get("pokemon?limit=100&offset=0");
      if (response.statusCode == 200) {
        Pokemon pokemon = Pokemon.fromJson(response.data);
        return Right(pokemon);
      } else {
        final Map<String, dynamic> decodedMessage =
            json.decode(response.toString());
        print("Error: ${decodedMessage['error']}");
        return Left(ErrorHandler(decodedMessage['error']));
      }
    } on DioError catch (error) {
      return Left(ErrorHandler(error.message));
    }
  }

  Future<Either<ErrorHandler, PokemonDetail>> getPokemonDetail(
      String url) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        PokemonDetail pokemon = PokemonDetail.fromJson(response.data);
        return Right(pokemon);
      } else {
        final Map<String, dynamic> decodedMessage =
            json.decode(response.toString());
        print("Error: ${decodedMessage['error']}");
        return Left(ErrorHandler(decodedMessage['error']));
      }
    } on DioError catch (error) {
      return Left(ErrorHandler(error.message));
    }
  }
}
