import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/use_cases/use_case.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_random-number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentaion/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia {
}

class MockRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockConcreteNumberTrivia mockConcreteNumberTrivia;
  MockRandomNumberTrivia mockRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockConcreteNumberTrivia = MockConcreteNumberTrivia();
    mockRandomNumberTrivia = MockRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        concrete: mockConcreteNumberTrivia,
        random: mockRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initial state should be empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;

    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test('''should call input converter to validate and 
        convert the string to an unsigned integer''', () async {
      setUpMockInputConverterSuccess();

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));

      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(' Should emit [Error] when input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
//asset later
      final expected = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test(' Should get data from the concrete use case', () async {
      setUpMockInputConverterSuccess();

      when(mockConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockConcreteNumberTrivia(any));

      verify(mockConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test(' Should emit [Loading, Loaded] when data is returned successfully',
        () async {
      setUpMockInputConverterSuccess();

      when(mockConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      final expected = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });

    test('Should emit [Loading, Error] when getting data fails', () async {
      setUpMockInputConverterSuccess();

      when(mockConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailures()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
    test(
        'Should emit [Loading, Error] with proper message for the error when getting data fails',
        () async {
      setUpMockInputConverterSuccess();

      when(mockConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailures()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {


    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');







    test(' Should get data from the random use case', () async {

      when(mockRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Right(tNumberTrivia));

      bloc.dispatch(GetTriviaForRandomNumber());
      await untilCalled(mockRandomNumberTrivia(any));

      verify(mockRandomNumberTrivia(NoParams()));
    });

    test(' Should emit [Loading, Loaded] when data is returned successfully',
        () async {

      when(mockRandomNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));

      final expected = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForRandomNumber());
    });

    test('Should emit [Loading, Error] when getting data fails', () async {

      when(mockRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailures()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForRandomNumber());
    });
    test(
        'Should emit [Loading, Error] with proper message for the error when getting data fails',
        () async {

      when(mockRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailures()));

      final expected = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expected));

      bloc.dispatch(GetTriviaForRandomNumber());
    });
  });
}
