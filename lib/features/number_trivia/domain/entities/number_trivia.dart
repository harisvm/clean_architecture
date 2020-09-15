import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class NumberTrivia extends Equatable {
  final String text;
  final String number;

  NumberTrivia({@required this.text, @required this.number})
      : super();

  @override
  List<Object> get props => [];
}
