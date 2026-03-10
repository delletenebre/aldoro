import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/locale_provider.dart';

class LocaleInterceptor extends QueuedInterceptor {
  final Ref ref;

  LocaleInterceptor(this.ref);

  @override
  void onRequest(options, handler) async {
    /// считываем значение из хранилища
    final locale = ref.read(localeProvider);

    /// обновляем заголовок accept-language
    options.headers[HttpHeaders.acceptLanguageHeader] = locale;

    return handler.next(options);
  }
}
