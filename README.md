# Firebase for Flutter

_This library is a work in progress, and is not officially supported
by the Firebase team._

This package exposes the [Firebase SDK](https://firebase.google.com/docs/)
to Flutter, on both iOS and Android. 
(Looking for Firebase v1 wrappers for Dart for the web? Check out the original [firebase-dart](https://github.com/firebase/firebase-dart).)

## Status

This package currently provides an in-progress implementation of the 
Realtime Database and Authentication APIs used by the Firechat codelab.
This package does not yet support transactions and querying.

Support for more APIs is planned.
See the [API docs](https://flutter.github.io/firebase) for
a list of currently supported APIs.

## Learn more

Check out our [API docs](https://flutter.github.io/firebase), 
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

## Contributing

Files in the lib/generated folder require a Flutter engine to build.

Clone this repository into your Flutter engine repository's ```third_party/firebase``` directory.

To get the Firebase SDK, create a new iOS project and run ```pod init```.
Add the following to your Podfile:

```
target 'YOUR_PROJECT_NAME' do
pod 'Firebase'
pod 'FirebaseAuth'
pod 'FirebaseDatabase'
pod 'FirebaseStorage'
pod 'GoogleMobileAds'
pod 'FirebaseRemoteConfig'
pod 'Firebase/Crash'
end
```

Run ```pod install``` to download the Firebase SDK into the Pods directory.
Copy the contents of the Pods directory to the ```sdk/ios``` directory in this repository.

To build for iOS:
```
./sky/tools/gn --ios --simulator --enable-firebase
ninja -C out/ios_debug_sim/ third_party/firebase
./sky/tools/gn --ios --enable-firebase --runtime-mode release
ninja -C out/ios_release/ third_party/firebase
lipo out/ios_debug_sim/libFirebase.dylib out/ios_release/libFirebase.dylib -create -output third_party/firebase/lib/generated/ios/libFirebase.dylib
cp out/ios_debug_sim/gen/third_party/firebase/mojom/firebase.mojom.dart third_party/firebase/lib/generated
```

To build for Android:
```
./sky/tools/gn --android --enable-firebase
ninja -C out/android_debug/
cp out/android_debug//gen/third_party/firebase/interfaces_java.jar third_party/firebase/android/mojo/libs
cp out/android_debug//gen/mojo/public/java/bindings.jar third_party/firebase/android/mojo/libs
cp out/android_debug//gen/mojo/public/java/system.jar third_party/firebase/android/mojo/libs
cp out/android_debug/gen/third_party/firebase/mojom/firebase.mojom.dart third_party/firebase/lib/generated
(cd third_party/firebase/android && ./gradlew build)
cp -r third_party/firebase/android/mojo/build/intermediates/ third_party/firebase/lib/generated/android/ 2>&1 | grep -v 'Permission denied'
```

## License

See the [LICENSE file](https://github.com/flutter/firebase/blob/master/LICENSE).
