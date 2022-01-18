import 'package:elementary/elementary.dart';

class DefaultErrorHandler implements ErrorHandler {
  @override
  void handleError(Object error) {
    // ignore: avoid_print
    print(error);
  }
}