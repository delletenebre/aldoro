import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/api_service.dart';

final apiProvider = Provider((ref) => ApiService(ref));
