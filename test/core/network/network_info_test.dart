import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:show_movie_app/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

//import 'package:'

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo =
        NetworkInfoImpl(connectionChecker: mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forwad the call to InternetConnectionChecker.hasConnection',
        () async {
      final tHasConnectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      final result = await networkInfo.isConnected;

      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
