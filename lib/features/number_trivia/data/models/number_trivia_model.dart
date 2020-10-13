import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter/foundation.dart';

class NumberTriviaModel extends NumberTrivia{


  NumberTriviaModel({@required String text,@required number}):super(text:text,number:number);
}