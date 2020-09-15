import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NumberTrivia extends Equatable  {
  final String text;
  final int number;

  NumberTrivia({@required this.text, @required this.number})
      : super([text, number]);
}
