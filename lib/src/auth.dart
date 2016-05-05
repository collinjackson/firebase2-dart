import 'app.dart';
import 'flutter/auth.dart';

abstract class FirebaseAuth {
  FirebaseApp get app;
  static FirebaseAuth get instance => FirebaseAuthImpl.instance;

  /**
   * Authenticates a Firebase client using a provided Authentication token.
   * Takes a single token as an argument and returns a Future that will be
   * resolved when the authentication succeeds (or fails).
   *
   * auth in the Firebase JS library has been deprecated. The same behaviour is
   * now achieved by using authWithCustomToken
   */
  @deprecated
  Future auth(String token);

  /**
   * Authenticates a Firebase client using an authentication token or Firebase Secret.
   * Takes a single token as an argument and returns a Future that will be
   * resolved when the authentication succeeds (or fails).
   */
  Future authWithCustomToken(String token);

  /**
   * Authenticates a Firebase client using a new, temporary guest account.
   */
  // https://www.firebase.com/docs/web/guide/login/anonymous.html#section-logging-in
  Future authAnonymously({remember: 'default'});

  /**
   * Authenticates a Firebase client using an email / password combination.
   */
  Future authWithPassword(Map credentials);

  /**
   * Authenticates a Firebase client using a third party provider (github, twitter,
   * google, facebook). This method presents login form with a popup.
   */
  Future authWithOAuthPopup(provider, {remember: 'default', scope: ''});

  /**
   * Authenticates a Firebase client using a third party provider (github, twitter,
   * google, facebook). This method redirects to a login form, then back to your app.
   */
  Future authWithOAuthRedirect(provider, {remember: 'default', scope: ''});

  /**
   * Authenticates a Firebase client using OAuth access tokens or credentials.
   */
  Future authWithOAuthToken(provider, credentials,
      {remember: 'default', scope: ''});

  /**
   * Synchronously retrieves the current authentication state of the client.
   */
  dynamic getAuth();

  /**
   * Listens for changes to the client's authentication state.
   */
  Stream onAuth([context]);

  /**
   * Unauthenticates a Firebase client (i.e. logs out).
   */
  void unauth();
}
