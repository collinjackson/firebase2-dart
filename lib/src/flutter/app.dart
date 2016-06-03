import 'package:flutter/services.dart';

import '../generated/firebase.mojom.dart' as mojom;
import '../app.dart';

abstract class FirebaseAppImpl implements FirebaseApp {
  static final FirebaseApp instance = new _FirebaseApp();

  mojom.FirebaseProxy get proxy;
}

class _FirebaseApp extends FirebaseAppImpl {
  _FirebaseApp() : _proxy = shell.connectToApplicationService(
    "firebase::Firebase",
    mojom.Firebase.connectToService
  )  {
    _proxy.configure();
  }

  final mojom.FirebaseProxy _proxy;
  mojom.FirebaseProxy get proxy => _proxy;
}
