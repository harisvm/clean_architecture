import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/use_cases/use_case.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_random-number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid  Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {@required GetConcreteNumberTrivia concrete,
      @required GetRandomNumberTrivia random,
      @required this.inputConverter})
      : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold((failure) async* {
        yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
       yield* _eitherLoadedOrErrorState(failureOrTrivia);
      });
    }

    else if(event is GetTriviaForRandomNumber){
      yield Loading();
      final failureOrTrivia =
      await getRandomNumberTrivia(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);

    }
  }

  @override
  // TODO: implement initialState
  NumberTriviaState get initialState => Empty();

  String _mapFailureIntoMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailures:
        return SERVER_FAILURE_MESSAGE;

      case CacheFailures:
        return CACHE_FAILURE_MESSAGE;

      default:
        return 'Unexpected error';
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
      Either< Failure, NumberTrivia> failureOrTrivia) async* {

    yield failureOrTrivia.fold(
            (failure) => Error(message: _mapFailureIntoMessage(failure)),
            (trivia) => Loaded(trivia: trivia));


  }
}
