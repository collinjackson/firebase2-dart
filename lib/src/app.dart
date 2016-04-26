library firebase.firebase;

// import 'database.dart';
import 'auth.dart';

// Once conditional imports work, use dart:ui to determine whether to import
// the mojo or js implementations
// import 'js/firebase.dart';
import 'flutter/app.dart';

/**
 * A Firebase represents a particular location in your Firebase and can be used
 * for reading or writing data to that Firebase location.
 */
abstract class FirebaseApp {
  /**
   * Construct a new Firebase reference from a full Firebase URL.
   */
  factory FirebaseApp({
    String databaseUrl,
    String appId,
    String clientId,
    String apiKey
  }) {
    assert(databaseUrl != null);
    assert(appId != null);
    assert(clientId != null);
    assert(apiKey != null);
    return new FirebaseAppImpl(
      databaseUrl: databaseUrl,
      appId: appId,
      clientId: clientId,
      apiKey: apiKey
    );
  }

  // FirebaseDatabase get database;

  FirebaseAuth get auth;
}
