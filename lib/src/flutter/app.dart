import 'package:flutter/services.dart';

import '../../generated/firebase.mojom.dart' as mojom;
import '../app.dart';

abstract class FirebaseAppImpl implements FirebaseApp {
  static final FirebaseApp instance = new _FirebaseApp();

  mojom.FirebaseProxy get proxy;
}

class _FirebaseApp extends FirebaseAppImpl {
  _FirebaseApp() : _proxy = new mojom.FirebaseProxy.unbound() {
    shell.connectToService("firebase::Firebase", _proxy);
    _proxy.ptr.configure();
  }

  final mojom.FirebaseProxy _proxy;
  mojom.FirebaseProxy get proxy => _proxy;
}
