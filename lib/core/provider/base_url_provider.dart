import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = Provider.autoDispose<String>((ref) {
  return 'http://127.0.0.1:8000';
});
