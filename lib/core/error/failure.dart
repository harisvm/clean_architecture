import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable  {
  @override
  List get props => super.props;

  Failure();

}
