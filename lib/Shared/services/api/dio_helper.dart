import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioHelper {
  static Dio dio = Dio();

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String lang = 'en',
    String? auth,
  }) async {
    dio.options.headers = {'lang': lang, 'Authorization': auth};
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? auth,
  }) async {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    dio.options.headers = {'lang': lang, 'Authorization': auth};
    return await dio.post(url, data: data, queryParameters: query);
  }
}
