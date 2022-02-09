import 'package:dio/dio.dart';

import '../../data/services/http/http.dart';

class DioAdapter implements HttpClient {
  final Dio client;

  DioAdapter({
    required this.client,
  });

  @override
  Future request({
    required String url,
    required RequestMethod method,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
    Map<String, dynamic> headers = const {},
    List<Map<String, dynamic>> files = const [],
  }) async {
    late final Map<String, dynamic> defaultHeaders;

    if (headers.isNotEmpty) {
      defaultHeaders = headers;
    } else {
      defaultHeaders = {'Content-Type': 'application/json', 'accept': 'application/json'};
    }

    late final FormData? formData;
    if (files.isNotEmpty) {
      if (files.length == 1) {
        formData = FormData.fromMap({'file': MultipartFile.fromFileSync(files[0]['path'])});
      } else {
        formData = FormData.fromMap(
          {'files': files.map((file) => MultipartFile.fromFileSync(file['path'])).toList()}
            ..addAll(body.isNotEmpty ? body : {}),
        );
      }
    } else {
      formData = null;
    }

    Response response = Response(
      data: '',
      statusCode: 500,
      requestOptions: RequestOptions(
        path: url,
        headers: defaultHeaders,
      ),
    );

    late final Future<Response>? futureResponse;

    try {
      futureResponse = _getResponse(
        method: method,
        url: url,
        queryParameters: queryParameters,
        options: Options(
          headers: defaultHeaders,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
        formData: formData,
        body: body,
      );

      response = await futureResponse.timeout(const Duration(seconds: 5));
    } on Exception {
      throw HttpError.serverError();
    }
    return _handleResponse(response);
  }

  Future<Response<dynamic>> _getResponse({
    required RequestMethod method,
    required String url,
    Options? options,
    Map<String, dynamic> queryParameters = const {},
    FormData? formData,
    Map<String, dynamic> body = const {},
  }) {
    if (method == RequestMethod.get) {
      return client.get(url, queryParameters: queryParameters, options: options);
    } else if (method == RequestMethod.put) {
      return client.put(url, data: formData ?? body, options: options);
    } else if (method == RequestMethod.post) {
      return client.post(url, data: formData ?? body, options: options);
    } else if (method == RequestMethod.patch) {
      return client.patch(url, data: formData ?? body, options: options);
    } else if (method == RequestMethod.delete) {
      return client.delete(url, queryParameters: queryParameters, options: options);
    } else {
      return client.get(url, queryParameters: queryParameters, options: options);
    }
  }

  dynamic _handleResponse(Response response) {
    final message = (response.data['message'] ?? '').toString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data.isEmpty ? {} : response.data as Map<String, dynamic>;
    } else if (response.statusCode == 204) {
      return {};
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest(message: message);
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized(message: message);
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden(message: message);
    } else if (response.statusCode == 404) {
      throw HttpError.notFound(message: message);
    } else if (response.statusCode == 422) {
      throw HttpError.invalidData(message: message);
    } else {
      throw HttpError.serverError(message: message);
    }
  }
}
