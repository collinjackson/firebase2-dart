import 'package:flutter/services.dart';

import '../../generated/firebase.mojom.dart' as mojom;

class FirebaseAppImpl {
  FirebaseAppImpl({
    String databaseUrl,
    String appId,
    String clientId,
    String apiKey
  }) : _firebase = new mojom.FirebaseProxy.unbound() {
    shell.connectToService("firebase::Firebase", _firebase);
    _firebase.ptr.initialize(databaseUrl, appId, clientId, apiKey);
    print('success!');
  }

  mojom.FirebaseProxy _firebase;
}
