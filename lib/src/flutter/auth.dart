library firebase.flutter.auth;

import 'dart:async';

import 'package:flutter/services.dart';

import '../generated/firebase.mojom.dart' as mojom;
import '../auth.dart';
import 'app.dart';
import 'conversions.dart';

abstract class FirebaseAuthImpl {
  static final FirebaseAuth instance = new _FirebaseAuth(FirebaseAppImpl.instance);
}

class _FirebaseAuth implements FirebaseAuth {
  _FirebaseAuth(this.app);

  final FirebaseAppImpl app;

  @deprecated
  Future auth(String token) => null;

  // Future authWithCustomToken(String token) {
  //   Completer completer = new Completer();
  //   app.proxy.authWithCustomToken(token).then(_getAuthCallback(completer));
  //   return completer.future;
  // }

  Future signInAnonymously() {
    Completer completer = new Completer();
    // TODO(jackson): should call getUserCallback but it throws an exception
    // after updating to latest mojo
    app.proxy.signInAnonymously().then((params) {
      if (params.error != null)
        completer.complete(params.user);
      else
        completer.completeError(params.error);
    });
    return completer.future;
  }

  // Future authWithPassword(Map credentials) {
  //   Completer completer = new Completer();
  //   app.proxy
  //     .authWithPassword(credentials["email"], credentials["password"])
  //     .then(_getAuthCallback(completer));
  //   return completer.future;
  // }
  //
  // Future authWithOAuthPopup(provider, {remember: 'default', scope: ''}) {
  //   throw new UnsupportedError("$runtimeType.authWithOAuthPopup");
  // }
  //
  // Future authWithOAuthRedirect(provider, {remember: 'default', scope: ''}) {
  //   throw new UnsupportedError("$runtimeType.authWithOAuthRedirect");
  // }
  //
  // Future authWithOAuthToken(String provider, String credentials,
  //     {remember: 'default', scope: ''}) {
  //   // The remember and scope arguments are intentionally ignored
  //   Completer completer = new Completer();
  //   app.proxy
  //     .authWithOAuthToken(provider, credentials)
  //     .then(_getAuthCallback(completer));
  //   return completer.future;
  // }

  dynamic getAuth() => throw new UnimplementedError();

  Stream onAuth([context]) => throw new UnimplementedError();

  Future signOut() {
    Completer completer = new Completer();
    app.proxy.signOut().then(getUserCallback(completer));
    return completer.future;
  }
}
