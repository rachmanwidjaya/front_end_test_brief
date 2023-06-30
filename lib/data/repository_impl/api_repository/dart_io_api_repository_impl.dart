import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../../config/enum/http_method.dart';
import '../../../core/exceptions/fetch_data_exeption.dart';
import '../../../domain/repository/api_repository.dart';

class DartIOApiRepositoryImpl implements ApiRepository {
  static const requestTimeOut = Duration(seconds: 10);
  static final _singleton = DartIOApiRepositoryImpl();
  static DartIOApiRepositoryImpl get instance => _singleton;
  @override
  Future<String> request(String endPoint,
      {HTTPMethod? method, Map<String, String>? headers, body}) async {
    log(endPoint, name: '${method ?? HTTPMethod.get}');
    try {
      final requestHeaders = headers ?? {};
      requestHeaders['Content-Type'] = 'application/json';
      final client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      client.connectionTimeout = requestTimeOut;
      final uri = Uri.parse(endPoint);
      final request = await client.openUrl(
          method != null
              ? method.toMethodString()
              : HTTPMethod.get.toMethodString(),
          uri);
      requestHeaders.forEach(
        (key, value) {
          request.headers.add(key, value);
        },
      );

      if (body != null) {
        request.write(json.encode(body));
      }
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      return handleResponse(response.statusCode, responseBody);
    } on TimeoutException catch (e, s) {
      throw FetchDataExeption(
          message: 'Request time out', error: e, stackTrace: s);
    } on SocketException catch (e, s) {
      throw FetchDataExeption(
          message: 'Connection Error', error: e, stackTrace: s);
    } on FormatException catch (e, s) {
      throw FetchDataExeption(
          message: 'Invalid Response format', error: e, stackTrace: s);
    } on HttpException catch (e, s) {
      throw FetchDataExeption(
          message: 'Connection closed while receiving data',
          error: e,
          stackTrace: s);
    } catch (e, s) {
      throw FetchDataExeption(message: '$e', error: e, stackTrace: s);
    }
  }
}
