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

    test('''should call input converter to validate and 
        convert the string to an unsigned integer''', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));

      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test(' Should emit [Error] when input is invalid', () async {
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
//asset later
      final expected = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];
      expectLater(
          bloc.state,
          emitsInOrder(expected));

      bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));

    });
  });
}
