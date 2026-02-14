import 'package:flutter/foundation.dart';

class GroupProvider with ChangeNotifier {
  String? _token;

  void initialize(String? token) {
    _token = token;
  }
}
