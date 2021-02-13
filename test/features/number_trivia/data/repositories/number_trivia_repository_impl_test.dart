import 'package:clean_architecture_tdd/core/error/failure.dart';
import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:clean_architecture_tdd/core/error/exceptions.dart';

class MockRemoteDateSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDateSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  MockRemoteDateSource mockRemoteDateSource;
  MockLocalDateSource mockLocalDateSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDateSource = MockLocalDateSource();
    mockRemoteDateSource = MockRemoteDateSource();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDateSource,
      localDataSource: mockLocalDateSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body){

    group('device is online', ()
    {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });


      body();
    });
  }
  void runTestsOffline(Function body){

    group('device is offline', ()
    {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });


      body();
    });
  }


  group('GetConcrete Number Trivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(number: tNumber, text: "test trivia");

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repositoryImpl.getConcreteNumberTrivia(tNumber);
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline( () {


      test(
          'should return remote data when the call to remote dateasource is success',
          () async {
        when(mockRemoteDateSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

        verify(mockRemoteDateSource.getConcreteNumberTrivia(tNumber));
        expect(result,Right(NumberTriviaModel()));

      });

      test(
          'should cache the data locally when call to remote data source is successfull',
          () async {
        when(mockRemoteDateSource.getConcreteNumberTrivia(any))

            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);


         verify(mockRemoteDateSource.getConcreteNumberTrivia(tNumber));
         verify(mockLocalDateSource.cacheNumberTrivia(tNumberTriviaModel));
        // expect(result,mockLocalDateSource.cacheNumberTrivia(NumberTriviaModel(text: 'hi', number:1)));

      });

      test(
          'should return server failure when the call to remote dateasource is unsuccessful',
              () async {
            when(mockRemoteDateSource.getConcreteNumberTrivia(any))
                .thenThrow(ServerExceptions());

            final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockLocalDateSource);

            verify(mockRemoteDateSource.getConcreteNumberTrivia(tNumber));
            expect(result,Left(ServerFailures()));

          });

    });
    runTestsOffline( () {

      test(
          'should return last locally cached data when cached data is present',
              () async {
            when(mockLocalDateSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);

            final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockRemoteDateSource);

            verify(mockLocalDateSource.getLastNumberTrivia());
            expect(result,Right(NumberTriviaModel()));

          });


      test(
          'should return CacheFailure when there is no cached data is present',
              () async {
            when(mockLocalDateSource.getLastNumberTrivia())
                .thenThrow(CacheExceptions());

            final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
            verifyZeroInteractions(mockRemoteDateSource);

            verify(mockLocalDateSource.getLastNumberTrivia());
            expect(result,Left(CacheFailures()));

          });

    });
  });



  group('GetRandom Number Trivia', () {

    final tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: "test trivia");

    test("Should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repositoryImpl.getRandomNumberTrivia();
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline( () {


      test(
          'should return remote data when the call to remote dateasource is success',
          () async {
        when(mockRemoteDateSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getRandomNumberTrivia();

        verify(mockRemoteDateSource.getRandomNumberTrivia());
        expect(result,Right(NumberTriviaModel()));

      });

      test(
          'should cache the data locally when call to remote data source is successfull',
          () async {
        when(mockRemoteDateSource.getRandomNumberTrivia())

            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repositoryImpl.getRandomNumberTrivia();


         verify(mockRemoteDateSource.getRandomNumberTrivia());
         verify(mockLocalDateSource.cacheNumberTrivia(tNumberTriviaModel));
        // expect(result,mockLocalDateSource.cacheNumberTrivia(NumberTriviaModel(text: 'hi', number:1)));

      });

      test(
          'should return server failure when the call to remote dateasource is unsuccessful',
              () async {
            when(mockRemoteDateSource.getRandomNumberTrivia())
                .thenThrow(ServerExceptions());

            final result = await repositoryImpl.getRandomNumberTrivia();
            verifyZeroInteractions(mockLocalDateSource);

            verify(mockRemoteDateSource.getRandomNumberTrivia());
            expect(result,Left(ServerFailures()));

          });

    });
    runTestsOffline( () {

      test(
          'should return last locally cached data when cached data is present',
              () async {
            when(mockLocalDateSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);

            final result = await repositoryImpl.getRandomNumberTrivia();
            verifyZeroInteractions(mockRemoteDateSource);

            verify(mockLocalDateSource.getLastNumberTrivia());
            expect(result,Right(NumberTriviaModel()));

          });


      test(
          'should return CacheFailure when there is no cached data is present',
              () async {
            when(mockLocalDateSource.getLastNumberTrivia())
                .thenThrow(CacheExceptions());

            final result = await repositoryImpl.getRandomNumberTrivia();
            verifyZeroInteractions(mockRemoteDateSource);

            verify(mockLocalDateSource.getLastNumberTrivia());
            expect(result,Left(CacheFailures()));

          });

    });
  });
}
