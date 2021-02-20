part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
   NumberTriviaEvent([List props = const <dynamic>[]]):super();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString):super([numberString]);

  @override
  List<Object> get props => [];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  GetTriviaForRandomNumber();

  @override
  List<Object> get props => [];
}
