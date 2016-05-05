import 'dart:async';

abstract class FirebaseAuthImpl {
  static final FirebaseAuth instance = new _FirebaseAuth(FirebaseAppImpl.instance);
}

class _FirebaseAuth implements FirebaseAuth {
  @deprecated
  Future auth(String token) => null;

  Future authWithCustomToken(String token) {
    Completer completer = new Completer();
    _proxy.ptr.authWithCustomToken(token).then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authAnonymously({remember: 'default'}) {
    Completer completer = new Completer();
    _proxy.ptr.authAnonymously().then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authWithPassword(Map credentials) {
    Completer completer = new Completer();
    _proxy.ptr
      .authWithPassword(credentials["email"], credentials["password"])
      .then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authWithOAuthPopup(provider, {remember: 'default', scope: ''}) {
    throw new UnsupportedError("$runtimeType.authWithOAuthPopup");
  }

  Future authWithOAuthRedirect(provider, {remember: 'default', scope: ''}) {
    throw new UnsupportedError("$runtimeType.authWithOAuthRedirect");
  }

  Future authWithOAuthToken(String provider, String credentials,
      {remember: 'default', scope: ''}) {
    // The remember and scope arguments are intentionally ignored
    Completer completer = new Completer();
    _proxy.ptr
      .authWithOAuthToken(provider, credentials)
      .then(_getAuthCallback(completer));
    return completer.future;
  }

  Function _getAuthCallback(Completer completer) {
    return (response) {
      if (response.error != null) {
        completer.completeError(response.error);
      } else {
        completer.complete(decodeAuthData(response.authData));
      }
    };
  }

  dynamic getAuth() => throw new UnimplementedError();

  Stream onAuth([context]) => throw new UnimplementedError();

  void unauth() {
    _firebase.ptr.unauth();
  }
}
