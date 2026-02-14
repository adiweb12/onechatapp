import 'package:flutter/foundation.dart';

class EventProvider with ChangeNotifier {
  String? _token;

  void initialize(String? token) {
    _token = token;
  }
}
