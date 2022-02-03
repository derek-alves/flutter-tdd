import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });
  Future<void> call() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required final String url});
}

class HttpClientSpy extends Mock implements HttpClient {
  When _mockRequestCall() => when(
        () => request(
          url: any(named: 'url'),
        ),
      );

  void mockRequest<T>() => _mockRequestCall().thenAnswer((final _) async => {});
}

void main() {
  late String url;
  late HttpClientSpy httpClient;
  late RemoteAuthentication sut;
  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);

    httpClient.mockRequest();
  });
  test(
    'Should call HttpClien with correct URL',
    () async {
      await sut.call();

      verify(() => httpClient.request(url: url));
    },
  );
}
