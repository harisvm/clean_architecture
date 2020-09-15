import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test',number: 1);
  test('Should get concrete number trivia', () async{

    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any)).thenAnswer((realInvocation) async => Right(tNumberTrivia));
  });
}
