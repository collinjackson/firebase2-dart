library firebase.app;

import 'flutter/app.dart';

abstract class FirebaseApp {
  static FirebaseApp get instance => FirebaseAppImpl.instance;
}
