import 'dart:convert';

import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart' as matcher;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a URL with number being 
        the end point and with application/json header''', () async {
      setUpMockHttpClientSuccess200();

      dataSourceImpl.getConcreteNumberTrivia(tNumber);

      verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });

    test('''should return number trivia when the response
     code is 200''', () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test('''should throw a ServerException when the
     response code is 404 or other''', () async {
      setUpMockHttpClientFailure404();
      final call = dataSourceImpl.getConcreteNumberTrivia;

      expect(call(tNumber), throwsA(matcher.TypeMatcher<ServerExceptions>()));
    });
  });


  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a URL with number being 
        the end point and with application/json header''', () async {
      setUpMockHttpClientSuccess200();

      dataSourceImpl.getRandomNumberTrivia();

      verify(mockHttpClient.get('http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'}));
    });

    test('''should return number trivia when the response
     code is 200''', () async {
      setUpMockHttpClientSuccess200();

      final result = await dataSourceImpl.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test('''should throw a ServerException when the
     response code is 404 or other''', () async {
      setUpMockHttpClientFailure404();
      final call = dataSourceImpl.getRandomNumberTrivia();

      expect(call, throwsA(matcher.TypeMatcher<ServerExceptions>()));
    });
  });
}
