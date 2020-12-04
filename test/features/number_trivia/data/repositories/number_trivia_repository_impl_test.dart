import 'package:clean_architecture_tdd/core/platform/network_info.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_local_datasource.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
}
