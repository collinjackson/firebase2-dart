A Flutter wrapper for [Firebase](http://firebase.google.com/).

This package currently makes [Firebase Realtime Database](https://firebase.google.com/docs/database/)
available to Flutter, for both iOS and Android. Further Firebase APIs support
is planned.

(Looking for Firebase v1 wrappers for Dart for the web? Check out [firebase-dart](https://github.com/firebase/firebase-dart).)

## Status

This package's support for Firebase Realtime Database API is fairly complete
for both iOS and Android.
This package does not yet provide wrappers for the other Firebase APIs.

## Learn more

Check out our API docs, codelab, and example app. (TODO: links.)

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
