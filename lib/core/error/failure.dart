import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List props = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}
//General failures

class ServerFailures extends Failure{
  final String message;

  ServerFailures({this.message});
}

class CacheFailures extends Failure{


}