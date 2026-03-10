import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/storage_provider.dart';

class AuthenticatorInterceptor extends QueuedInterceptor {
  final Ref ref;

  AuthenticatorInterceptor(this.ref);

  @override
  void onRequest(options, handler) async {
    try {
      /// сохранённый ключ авторизации
      final authToken = await readSavedAuthTokens();

      if (authToken.isNotEmpty) {
        /// ^ если токен авторизации сохранён

        /// обновляем заголовок authorization
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $authToken';

        debugPrint('Bearer $authToken');
      }
    } catch (e) {}

    return handler.next(options);
  }

  @override
  void onError(err, handler) async {
    if (err.type == DioExceptionType.badResponse &&
        err.response!.statusCode == 401) {
      /// контроллер аккаунта
      final authController = ref.read(authProvider.notifier);

      /// сохранённый ключ авторизации
      final authToken = await readSavedAuthTokens();

      if (authToken.isNotEmpty) {
        /// ^ если токен авторизации сохранён

        final dioRefresh = Dio(
          BaseOptions(
            baseUrl: err.requestOptions.baseUrl,
            headers: {
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $authToken',
            },
          ),
        );
        // final refreshData = {'refresh_token': authTokens.refreshToken};

        if (kDebugMode) {
          dioRefresh.interceptors.add(
            LogInterceptor(responseBody: true, requestBody: true),
          );
        }

        return handler.reject(err);

        // try {
        //   /// обновляем заголовок authorization
        //   final response = await dioRefresh.post(
        //     '/v1/auth/refresh',
        //     // data: refreshData,
        //   );

        //   final authTokens = AuthTokens.fromJson(response.data);

        //   /// хранилище данных
        //   final storage = ref.read(storageProvider);
        //   storage.writeSecure('tokens', authTokens.toJson());

        //   /// обновляем ключ доступа в предыдущем запросе
        //   final headers = err.requestOptions.headers;
        //   headers[HttpHeaders.authorizationHeader] =
        //       'Bearer ${authTokens.accessToken}';

        //   /// выполняем предыдущий запрос
        //   final resp = await Dio().fetch(
        //     err.requestOptions.copyWith(headers: headers),
        //   );

        //   return handler.resolve(resp);
        // } on DioException catch (dioException) {
        //   // if (dioException.response?.statusCode == 401) {
        //   /// выходим из профиля
        //   authController.signOut();
        //   // }

        //   return handler.reject(err);
        // } catch (exception) {
        //   return handler.reject(err);
        // }
      } else {
        /// выходим из профиля
        authController.signOut();

        return handler.reject(err);
      }
    }

    return super.onError(err, handler);
  }

  /// считываем accessToken из хранилища
  Future<String> readSavedAuthTokens() async {
    /// хранилище данных
    final storage = ref.read(storageProvider);

    /// считываем значение из хранилища
    final savedValue = await storage.readSecure(
      AuthNotifier.prefsKey,
      defaultValue: '',
    );

    return savedValue;
  }
}
