import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String? userType;
  int? userId;
  String? nome;
  String? email;

  void setAuth(Map<String, dynamic> data) {
    userType = data['userType']?.toString();
    final idVal = data['userId'];
    if (idVal is int) {
      userId = idVal;
    } else if (idVal is num) {
      userId = idVal.toInt();
    } else if (idVal is String) {
      userId = int.tryParse(idVal);
    }
    nome = data['nome']?.toString();
    email = data['email']?.toString();
    notifyListeners();
  }

  void clear() {
    userType = null;
    userId = null;
    nome = null;
    email = null;
    notifyListeners();
  }
}

