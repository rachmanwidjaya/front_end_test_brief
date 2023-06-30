// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:get/get.dart';

// import '../../../config/enum/http_method.dart';
// import '../../../core/exceptions/fetch_data_exeption.dart';
// import '../../../domain/repository/api_repository.dart';

// class GetConnectApiRepositoryImpl implements ApiRepository {
//   static const requestTimeOut = Duration(seconds: 10);
//   static final _singleton = GetConnectApiRepositoryImpl();
//   static GetConnectApiRepositoryImpl get instance => _singleton;

//   final _httpClient = GetConnect();

//   @override
//   Future<String> request(String endPoint,
//       {HTTPMethod? method, Map<String, String>? headers, body}) async {
//     log(endPoint, name: '${method ?? HTTPMethod.get}');
//     try {
//       final request = _httpClient.request(
//         endPoint,
//         method != null
//             ? method.toMethodString()
//             : HTTPMethod.get.toMethodString(),
//         body: body,
//         headers: headers ?? {},
//       );

//       request.timeout(requestTimeOut);

//       final response = await request;
//       return handleResponse(
//           response.statusCode ?? 0, response.bodyString ?? '');
//     } on TimeoutException catch (e, s) {
//       throw FetchDataExeption(
//           message: 'Request time out', error: e, stackTrace: s);
//     } on SocketException catch (e, s) {
//       throw FetchDataExeption(
//           message: 'Connection Error', error: e, stackTrace: s);
//     } on FormatException catch (e, s) {
//       throw FetchDataExeption(
//           message: 'Invalid Response format', error: e, stackTrace: s);
//     } catch (e, s) {
//       throw FetchDataExeption(message: '$e', error: e, stackTrace: s);
//     }
//   }
// }
