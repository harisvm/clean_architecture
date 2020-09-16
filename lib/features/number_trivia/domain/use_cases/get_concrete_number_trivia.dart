import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
