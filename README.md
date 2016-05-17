A Flutter wrapper for [Firebase](http://firebase.google.com/).

This package exposes the [Firebase SDK](https://firebase.google.com/docs/)
to Flutter, on both iOS and Android. 
(Looking for Firebase v1 wrappers for Dart for the web? Check out the original [firebase-dart](https://github.com/firebase/firebase-dart).)

## Status

This package currently provides an implementation of the 
Realtime Database and Authentication APIs used by the Firechat codelab.
Support for more APIs is planned. See the [API docs](https://flutter.github.io/firebase-dart) for
a list of currently supported APIs.

Firebase does not officially support this package. The Flutter
team maintains this package.

## Learn more

Check out our [API docs](https://flutter.github.io/firebase-dart), 
[codelab](https://codelabs.developers.google.com/codelabs/flutter/), and
[example app](https://github.com/flutter/firechat-flutter/).

Here are some snippets to give you a flavor of the API:

```dart
// Import the Firebase library:
import 'package:firebase/firebase.dart';

// Get a reference to the database object:
var database = FirebaseDatabase.instance.reference();

// Append a message to the end of an array in Firebase Database:
var message = {
  'text': value.text,
};
database.push().set(message);

// Listen for newly added messages:
database.onChildAdded.listen((Event event) {
  // Do cool stuff.
});
```

## License

See the [LICENSE file](https://github.com/flutter/firebase2-dart/blob/master/LICENSE).
