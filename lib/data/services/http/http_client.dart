abstract class HttpClient {
  Future<dynamic> request({
    required final String url,
    required final RequestMethod method,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    Map<String, dynamic> headers = const {},
    List<Map<String, dynamic>> files = const [],
  });
}

enum RequestMethod {
  get,
  put,
  post,
  patch,
  delete,
}
