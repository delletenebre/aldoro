import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/user.dart';
import 'storage_provider.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  () => AuthNotifier(),
);

class AuthNotifier extends AsyncNotifier<User?> {
  /// ключ в хранилище
  static const prefsKey = 'tokens';

  @override
  Future<User?> build() async {
    return null;
  }

  /// авторизация на сервере
  Future<void> signIn(String code, String sessionState) async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 3));
    state = const AsyncValue.data(null);
  }

  /// выход из профиля
  Future<void> signOut() async {
    /// локальное хранилище данных
    final storage = ref.read(storageProvider);

    /// удаляем ключи авторизации
    await storage.removeSecure(prefsKey);

    state = const AsyncValue.data(null);
  }
}
