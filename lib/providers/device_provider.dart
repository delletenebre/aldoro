// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// import '../models/device.dart';

// final deviceProvider = FutureProvider((ref) async {
//   /// инициализируем локальное хранилище
//   final sharedPreferences = await SharedPreferences.getInstance();

//   /// считываем идентификатор установки
//   String? installationId = sharedPreferences.getString('installation_id');

//   if (installationId == null) {
//     /// генерируем идентификатор установки
//     installationId = const Uuid().v4();

//     /// сохраняем идентификатор установки
//     await sharedPreferences.setString('installation_id', installationId);
//   }

//   /// инициализируем информацию о приложении
//   final packageInfo = await PackageInfo.fromPlatform();

//   /// инициализируем информацию об устройстве
//   final deviceInfo = DeviceInfoPlugin();

//   if (Platform.isMacOS) {
//     /// ^ если macos

//     final info = await deviceInfo.macOsInfo;
//     return Device(
//       id: installationId,
//       name: info.model,
//       vendor: 'Apple',
//       osVersion:
//           'macOS ${info.majorVersion}.${info.minorVersion}.${info.patchVersion}',
//       applicationVersion: packageInfo.version,
//     );
//   } else if (Platform.isWindows) {
//     /// ^ если windows
//     ///
//     final info = await deviceInfo.windowsInfo;
//     return Device(
//       id: installationId,
//       name: info.computerName,
//       vendor: 'Microsoft Corporation',
//       osVersion: info.productName,
//       applicationVersion: packageInfo.version,
//     );
//   } else if (Platform.isAndroid) {
//     /// ^ если android

//     final info = await deviceInfo.androidInfo;
//     return Device(
//       id: installationId,
//       name: info.model,
//       vendor: info.brand,
//       osVersion: info.version.release,
//       applicationVersion: packageInfo.version,
//     );
//   } else {
//     return Device(id: installationId, applicationVersion: packageInfo.version);
//   }
// });
