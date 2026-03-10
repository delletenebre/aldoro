import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'authenticator_interceptor.dart';
import 'locale_interceptor.dart';

class ApiService {
  final Ref ref;

  CancelToken getCancelToken() => CancelToken();

  late final Dio dio;

  ApiService(this.ref) {
    dio = Dio(
      BaseOptions(
        // baseUrl: DEBUG_API,
        baseUrl: '',
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    /// добавляем перехватчик, для логов запросов
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
        ),
      );
    }

    /// добавляем перехватчик, для обновления данных заголовка Authenticator
    dio.interceptors.add(AuthenticatorInterceptor(ref));

    /// добавляем перехватчик, для языка приложения
    dio.interceptors.add(LocaleInterceptor(ref));
  }
}
