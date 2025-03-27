import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/services/api_manager.dart';

final Provider<ApiManager> apiManagerProvider = Provider<ApiManager>((ref) {
  return ApiManager();
});
