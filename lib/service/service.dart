import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:victor_flutter/components/constants.dart';
import 'package:victor_flutter/model/categories.dart';
import 'package:victor_flutter/model/starships.dart';

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

  Future<Either<ErrorHandler, Categories>> getCategories() async {
    try {
      Response response = await dio.get("");
      if (response.statusCode == 200) {
        Categories categories = Categories.fromJson(response.data);
        return Right(categories);
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

  Future<Either<ErrorHandler, Starships>> getAllStarships() async {
    try {
      Response response = await dio.get("/starships");
      if (response.statusCode == 200) {
        Starships starships = Starships.fromJson(response.data);
        return Right(starships);
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
