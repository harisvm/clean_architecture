import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource{
/// will return the cached data when there is no internet
  /// throws [CacheExceptions] if no data is returned
  Future<NumberTriviaModel> getLastNumberTrivia();

  /// every time NumberTrivia is returned from remote data source
  /// it is cached inside shared preferences
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}