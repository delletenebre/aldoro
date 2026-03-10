import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences sharedStorage;
  final FlutterSecureStorage secureStorage;

  Storage({required this.sharedStorage, required this.secureStorage});

  final ValueNotifier<Map<String, dynamic>> _notifier = ValueNotifier({});
  ValueNotifier<Map<String, dynamic>> get notifier => _notifier;
  void _notifyChange(String key, dynamic value) {
    _notifier.value = {..._notifier.value, key: value};
  }

  /// чтение данных из обычного хранилища
  String read(String key, {String defaultValue = ''}) {
    return sharedStorage.getString(key) ?? defaultValue;
  }

  /// чтение данных из обычного хранилища
  bool readBool(String key, [bool defaultValue = false]) {
    return sharedStorage.getBool(key) ?? defaultValue;
  }

  /// чтение списка из обычного хранилища
  List<T> readList<T>(String key, {dynamic defaultValue = const {}}) {
    late String defValue;
    if (defaultValue is Map || defaultValue is List) {
      defValue = jsonEncode(defaultValue);
    } else {
      defValue = defaultValue;
    }

    return jsonDecode(sharedStorage.getString(key) ?? defValue);
  }

  /// запись данных в обычное хранилище
  Future<void> write(String key, dynamic value) async {
    if (value is bool) {
      sharedStorage.setBool(key, value);
    } else if (value is String) {
      sharedStorage.setString(key, value);
    }
    _notifyChange(key, value);
  }

  /// запись списка в обычное хранилище
  void writeList<T>(String key, List<T> value) => write(key, jsonEncode(value));

  /// удаляем данные из обычного хранилища
  Future<void> remove(String key) async {
    sharedStorage.remove(key);
  }

  /// чтение данных из защищённого хранилища
  Future<String> readSecure(String key, {String defaultValue = ''}) async {
    return (await secureStorage.read(key: key)) ?? defaultValue;
  }

  /// запись данных в защищённое хранилище
  Future<void> writeSecure(String key, dynamic value) async {
    if (value is Map) {
      value = json.encode(value);
    } else {
      value = value.toString();
    }

    // await removeSecure(key);
    await secureStorage.write(key: key, value: value);
  }

  /// удаляем данные из защищённого хранилища
  Future<void> removeSecure(String key) async {
    if (await secureStorage.containsKey(key: key)) {
      secureStorage.delete(key: key);
    }
  }
}
