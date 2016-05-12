import 'dart:async';

Function getResultCallback(Completer completer) {
  return (response) {
    if (response.error != null) {
      completer.completeError(response.error);
    } else {
      completer.complete();
    }
  };
}

Function getUserCallback(Completer completer) {
  return (response) {
    if (response.error != null) {
      completer.completeError(response.error);
    } else {
      completer.complete(response.user);
    }
  };
}
