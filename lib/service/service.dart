import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:victor_flutter/helpers/constants.dart';
import 'package:victor_flutter/model/location.dart';
import 'package:victor_flutter/model/location_detail.dart';
import 'package:victor_flutter/model/location_info.dart';
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

  Future<Either<ErrorHandler, Pokemon>> getPokemons(int offset) async {
    try {
      Response response = await dio.get("pokemon?limit=100&offset=$offset");
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

  Future<Either<ErrorHandler, Location>> getLocations(int offset) async {
    try {
      Response response = await dio.get("location?limit=100&offset=$offset");
      if (response.statusCode == 200) {
        Location location = Location.fromJson(response.data);
        return Right(location);
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

  Future<Either<ErrorHandler, LocationInfo>> getLocationInfo(String url) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        LocationInfo locationInfo = LocationInfo.fromJson(response.data);
        return Right(locationInfo);
      } else {
        return Left(ErrorHandler(response.data));
      }
    } on DioError catch (error) {
      return Left(ErrorHandler(error.message));
    }
  }

  Future<Either<ErrorHandler, LocationDetail>> getLocationDetail(
      String url) async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        LocationDetail locationDetail = LocationDetail.fromJson(response.data);
        return Right(locationDetail);
      } else {
        return Left(ErrorHandler(response.data));
      }
    } on DioError catch (error) {
      return Left(ErrorHandler(error.message));
    }
  }
}
