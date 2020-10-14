import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

final tNumberTriviaModel = NumberTriviaModel(number:1,text:'Text test');



test('should be a subclass of number trivia entity', () async{
expect(tNumberTriviaModel, isA<NumberTrivia>());

});
}