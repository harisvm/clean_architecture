import 'package:clean_architecture_tdd/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {
}

  void main(){

    MockDataConnectionChecker mockDataConnectionChecker;
    NetworkInfoImpl networkInfoImpl; 
    setUp((){
      mockDataConnectionChecker = MockDataConnectionChecker();
      networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
    });
    
    group('is connected', (){
      test('Should call DataConnectionChecker.hasConnection', ()async{

        when(mockDataConnectionChecker.hasConnection).thenAnswer((realInvocation) async =>true );

     final result =  await networkInfoImpl.isConnected;
     verify(mockDataConnectionChecker.hasConnection);
     expect(result, true);

      });

      
    });
  }
