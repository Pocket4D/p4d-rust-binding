import 'package:flutter_test/flutter_test.dart';
// import 'package:p4d_rust_binding/utils/utils.dart';

Matcher assertionThrowsContains(String str) {
  return isAssertionError.having((e) => e.message, "message", contains(str));
}
