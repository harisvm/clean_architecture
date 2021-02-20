import 'dart:convert';

import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  /// will return the cached data when there is no internet
  /// throws [CacheExceptions] if no data is returned
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// every time NumberTrivia is returned from remote data source
  /// it is cached inside shared preferences
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {


    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
if(jsonString !=null){
  return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));

}

else{

  throw CacheExceptions();
}
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel) {
   
  return  sharedPreferences.setString(CACHED_NUMBER_TRIVIA,
      json.encode(triviaModel.toJson()));
  }
}
