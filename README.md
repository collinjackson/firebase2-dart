[![Build Status](https://travis-ci.org/firebase/firebase-dart.svg?branch=master)](https://travis-ci.org/firebase/firebase-dart)

A Dart wrapper for [Firebase](https://www.firebase.com).

This package contains two implementations of the same ```Firebase``` Dart API:
* The ```JsFirebase``` implementation uses `dart:js` to wrap functionality provided by `firebase.js`
in Dart classes. You'll need this implementation to build Firebase apps for the web.
* The ```FlutterFirebase``` implementation uses [Flutter](https://github.com/domokit/mojo) to wrap functionality provided by Firebase iOS and Android SDKs. You'll need this implementation to build Firebase apps with [Flutter](http:/flutter.io).

Right now the ```FlutterFirebase``` implementation is default, but you can change this in lib/src/firebase.dart. Once [dart-lang/sdk#24581](https://github.com/dart-lang/sdk/issues/24581) is fixed you'll get the right implementation automatically.

#### Installing

Follow the instructions on the [pub page](http://pub.dartlang.org/packages/firebase#installing).

#### Using Firebase on the web

**The firebase.js library MUST be included for the JavaScript wrapper to work**:

```html
<script src="https://cdn.firebase.com/js/client/2.3.2/firebase.js"></script>
```

### Building generated files from source

Files in the lib/generated folder require a Flutter engine to build.

Clone this repository into your Flutter engine repository's ```third_party/firebase``` directory.

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
