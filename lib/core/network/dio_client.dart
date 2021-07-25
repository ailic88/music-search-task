import 'package:dio/dio.dart';
import 'package:music_search_task/core/config/config.dart' as config;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final Dio dio;

  factory DioClient.createDioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 15000,
    );
    DioClient dioClient = DioClient._internal(Dio(options));

    return dioClient;
  }

  DioClient._internal(this.dio) {
    dio.interceptors
      ..add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
            options.queryParameters.addAll({"api_key": config.apiKey, "format": "json"});
            handler.next(options);
          },
        ),
      )
      ..add(
        PrettyDioLogger(
          maxWidth: 200,
          logPrint: (log) => print(log),
        ),
      );
  }
}
