// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library firebase_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class EventType extends bindings.MojoEnum {
  static const EventType eventTypeChildAdded = const EventType._(0);
  static const EventType eventTypeChildRemoved = const EventType._(1);
  static const EventType eventTypeChildChanged = const EventType._(2);
  static const EventType eventTypeChildMoved = const EventType._(3);
  static const EventType eventTypeValue = const EventType._(4);

  const EventType._(int v) : super(v);

  static const Map<String, EventType> valuesMap = const {
    "eventTypeChildAdded": eventTypeChildAdded,
    "eventTypeChildRemoved": eventTypeChildRemoved,
    "eventTypeChildChanged": eventTypeChildChanged,
    "eventTypeChildMoved": eventTypeChildMoved,
    "eventTypeValue": eventTypeValue,
  };
  static const List<EventType> values = const [
    eventTypeChildAdded,
    eventTypeChildRemoved,
    eventTypeChildChanged,
    eventTypeChildMoved,
    eventTypeValue,
  ];

  static EventType valueOf(String name) => valuesMap[name];

  factory EventType(int v) {
    switch (v) {
      case 0:
        return EventType.eventTypeChildAdded;
      case 1:
        return EventType.eventTypeChildRemoved;
      case 2:
        return EventType.eventTypeChildChanged;
      case 3:
        return EventType.eventTypeChildMoved;
      case 4:
        return EventType.eventTypeValue;
      default:
        return null;
    }
  }

  static EventType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    EventType result = new EventType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum EventType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case eventTypeChildAdded:
        return 'EventType.eventTypeChildAdded';
      case eventTypeChildRemoved:
        return 'EventType.eventTypeChildRemoved';
      case eventTypeChildChanged:
        return 'EventType.eventTypeChildChanged';
      case eventTypeChildMoved:
        return 'EventType.eventTypeChildMoved';
      case eventTypeValue:
        return 'EventType.eventTypeValue';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class DataSnapshot extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String key = null;
  String jsonValue = null;

  DataSnapshot() : super(kVersions.last.size);

  static DataSnapshot deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DataSnapshot decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DataSnapshot result = new DataSnapshot();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.key = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.jsonValue = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(key, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "key of struct DataSnapshot: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(jsonValue, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "jsonValue of struct DataSnapshot: $e";
      rethrow;
    }
  }

  String toString() {
    return "DataSnapshot("
           "key: $key" ", "
           "jsonValue: $jsonValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["key"] = key;
    map["jsonValue"] = jsonValue;
    return map;
  }
}


class Error extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int code = 0;
  String message = null;

  Error() : super(kVersions.last.size);

  static Error deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Error decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Error result = new Error();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.code = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.message = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(code, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "code of struct Error: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(message, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "message of struct Error: $e";
      rethrow;
    }
  }

  String toString() {
    return "Error("
           "code: $code" ", "
           "message: $message" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["code"] = code;
    map["message"] = message;
    return map;
  }
}


class User extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  String providerId = null;
  String uid = null;
  String displayName = null;
  String photoUrl = null;
  String email = null;

  User() : super(kVersions.last.size);

  static User deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static User decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    User result = new User();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.providerId = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.uid = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.displayName = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.photoUrl = decoder0.decodeString(32, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.email = decoder0.decodeString(40, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(providerId, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "providerId of struct User: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(uid, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "uid of struct User: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(displayName, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "displayName of struct User: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(photoUrl, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "photoUrl of struct User: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(email, 40, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "email of struct User: $e";
      rethrow;
    }
  }

  String toString() {
    return "User("
           "providerId: $providerId" ", "
           "uid: $uid" ", "
           "displayName: $displayName" ", "
           "photoUrl: $photoUrl" ", "
           "email: $email" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["providerId"] = providerId;
    map["uid"] = uid;
    map["displayName"] = displayName;
    map["photoUrl"] = photoUrl;
    map["email"] = email;
    return map;
  }
}


class _ValueEventListenerOnCancelledParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  _ValueEventListenerOnCancelledParams() : super(kVersions.last.size);

  static _ValueEventListenerOnCancelledParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ValueEventListenerOnCancelledParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ValueEventListenerOnCancelledParams result = new _ValueEventListenerOnCancelledParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct _ValueEventListenerOnCancelledParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ValueEventListenerOnCancelledParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _ValueEventListenerOnDataChangeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DataSnapshot snapshot = null;

  _ValueEventListenerOnDataChangeParams() : super(kVersions.last.size);

  static _ValueEventListenerOnDataChangeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ValueEventListenerOnDataChangeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ValueEventListenerOnDataChangeParams result = new _ValueEventListenerOnDataChangeParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct _ValueEventListenerOnDataChangeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ValueEventListenerOnDataChangeParams("
           "snapshot: $snapshot" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    return map;
  }
}


class _ChildEventListenerOnCancelledParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  _ChildEventListenerOnCancelledParams() : super(kVersions.last.size);

  static _ChildEventListenerOnCancelledParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ChildEventListenerOnCancelledParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ChildEventListenerOnCancelledParams result = new _ChildEventListenerOnCancelledParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct _ChildEventListenerOnCancelledParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ChildEventListenerOnCancelledParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _ChildEventListenerOnChildAddedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DataSnapshot snapshot = null;
  String previousChildName = null;

  _ChildEventListenerOnChildAddedParams() : super(kVersions.last.size);

  static _ChildEventListenerOnChildAddedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ChildEventListenerOnChildAddedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ChildEventListenerOnChildAddedParams result = new _ChildEventListenerOnChildAddedParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.previousChildName = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct _ChildEventListenerOnChildAddedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(previousChildName, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "previousChildName of struct _ChildEventListenerOnChildAddedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ChildEventListenerOnChildAddedParams("
           "snapshot: $snapshot" ", "
           "previousChildName: $previousChildName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    map["previousChildName"] = previousChildName;
    return map;
  }
}


class _ChildEventListenerOnChildChangedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DataSnapshot snapshot = null;
  String previousChildName = null;

  _ChildEventListenerOnChildChangedParams() : super(kVersions.last.size);

  static _ChildEventListenerOnChildChangedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ChildEventListenerOnChildChangedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ChildEventListenerOnChildChangedParams result = new _ChildEventListenerOnChildChangedParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.previousChildName = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct _ChildEventListenerOnChildChangedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(previousChildName, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "previousChildName of struct _ChildEventListenerOnChildChangedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ChildEventListenerOnChildChangedParams("
           "snapshot: $snapshot" ", "
           "previousChildName: $previousChildName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    map["previousChildName"] = previousChildName;
    return map;
  }
}


class _ChildEventListenerOnChildMovedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DataSnapshot snapshot = null;
  String previousChildName = null;

  _ChildEventListenerOnChildMovedParams() : super(kVersions.last.size);

  static _ChildEventListenerOnChildMovedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ChildEventListenerOnChildMovedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ChildEventListenerOnChildMovedParams result = new _ChildEventListenerOnChildMovedParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.previousChildName = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct _ChildEventListenerOnChildMovedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(previousChildName, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "previousChildName of struct _ChildEventListenerOnChildMovedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ChildEventListenerOnChildMovedParams("
           "snapshot: $snapshot" ", "
           "previousChildName: $previousChildName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    map["previousChildName"] = previousChildName;
    return map;
  }
}


class _ChildEventListenerOnChildRemovedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DataSnapshot snapshot = null;

  _ChildEventListenerOnChildRemovedParams() : super(kVersions.last.size);

  static _ChildEventListenerOnChildRemovedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ChildEventListenerOnChildRemovedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ChildEventListenerOnChildRemovedParams result = new _ChildEventListenerOnChildRemovedParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct _ChildEventListenerOnChildRemovedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ChildEventListenerOnChildRemovedParams("
           "snapshot: $snapshot" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    return map;
  }
}


class _DatabaseReferenceAddValueEventListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  ValueEventListenerInterface listener = null;

  _DatabaseReferenceAddValueEventListenerParams() : super(kVersions.last.size);

  static _DatabaseReferenceAddValueEventListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceAddValueEventListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceAddValueEventListenerParams result = new _DatabaseReferenceAddValueEventListenerParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.listener = decoder0.decodeServiceInterface(16, false, ValueEventListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceAddValueEventListenerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(listener, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _DatabaseReferenceAddValueEventListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceAddValueEventListenerParams("
           "path: $path" ", "
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _DatabaseReferenceAddChildEventListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  ChildEventListenerInterface listener = null;

  _DatabaseReferenceAddChildEventListenerParams() : super(kVersions.last.size);

  static _DatabaseReferenceAddChildEventListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceAddChildEventListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceAddChildEventListenerParams result = new _DatabaseReferenceAddChildEventListenerParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.listener = decoder0.decodeServiceInterface(16, false, ChildEventListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceAddChildEventListenerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(listener, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _DatabaseReferenceAddChildEventListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceAddChildEventListenerParams("
           "path: $path" ", "
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _DatabaseReferenceObserveSingleEventOfTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  EventType eventType = null;

  _DatabaseReferenceObserveSingleEventOfTypeParams() : super(kVersions.last.size);

  static _DatabaseReferenceObserveSingleEventOfTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceObserveSingleEventOfTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceObserveSingleEventOfTypeParams result = new _DatabaseReferenceObserveSingleEventOfTypeParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.eventType = EventType.decode(decoder0, 16);
        if (result.eventType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable EventType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceObserveSingleEventOfTypeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(eventType, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "eventType of struct _DatabaseReferenceObserveSingleEventOfTypeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceObserveSingleEventOfTypeParams("
           "path: $path" ", "
           "eventType: $eventType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    map["eventType"] = eventType;
    return map;
  }
}


class DatabaseReferenceObserveSingleEventOfTypeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DataSnapshot snapshot = null;

  DatabaseReferenceObserveSingleEventOfTypeResponseParams() : super(kVersions.last.size);

  static DatabaseReferenceObserveSingleEventOfTypeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DatabaseReferenceObserveSingleEventOfTypeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DatabaseReferenceObserveSingleEventOfTypeResponseParams result = new DatabaseReferenceObserveSingleEventOfTypeResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.snapshot = DataSnapshot.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(snapshot, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "snapshot of struct DatabaseReferenceObserveSingleEventOfTypeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DatabaseReferenceObserveSingleEventOfTypeResponseParams("
           "snapshot: $snapshot" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["snapshot"] = snapshot;
    return map;
  }
}


class _DatabaseReferenceSetValueParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String path = null;
  String jsonValue = null;
  int priority = 0;
  bool hasPriority = false;

  _DatabaseReferenceSetValueParams() : super(kVersions.last.size);

  static _DatabaseReferenceSetValueParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceSetValueParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceSetValueParams result = new _DatabaseReferenceSetValueParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.jsonValue = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.priority = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.hasPriority = decoder0.decodeBool(28, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceSetValueParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(jsonValue, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "jsonValue of struct _DatabaseReferenceSetValueParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(priority, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "priority of struct _DatabaseReferenceSetValueParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(hasPriority, 28, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hasPriority of struct _DatabaseReferenceSetValueParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceSetValueParams("
           "path: $path" ", "
           "jsonValue: $jsonValue" ", "
           "priority: $priority" ", "
           "hasPriority: $hasPriority" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    map["jsonValue"] = jsonValue;
    map["priority"] = priority;
    map["hasPriority"] = hasPriority;
    return map;
  }
}


class DatabaseReferenceSetValueResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  DatabaseReferenceSetValueResponseParams() : super(kVersions.last.size);

  static DatabaseReferenceSetValueResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DatabaseReferenceSetValueResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DatabaseReferenceSetValueResponseParams result = new DatabaseReferenceSetValueResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DatabaseReferenceSetValueResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DatabaseReferenceSetValueResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _DatabaseReferenceRemoveValueParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String path = null;

  _DatabaseReferenceRemoveValueParams() : super(kVersions.last.size);

  static _DatabaseReferenceRemoveValueParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceRemoveValueParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceRemoveValueParams result = new _DatabaseReferenceRemoveValueParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceRemoveValueParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceRemoveValueParams("
           "path: $path" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    return map;
  }
}


class DatabaseReferenceRemoveValueResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  DatabaseReferenceRemoveValueResponseParams() : super(kVersions.last.size);

  static DatabaseReferenceRemoveValueResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DatabaseReferenceRemoveValueResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DatabaseReferenceRemoveValueResponseParams result = new DatabaseReferenceRemoveValueResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DatabaseReferenceRemoveValueResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DatabaseReferenceRemoveValueResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _DatabaseReferencePushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  DatabaseReferenceInterfaceRequest child = null;

  _DatabaseReferencePushParams() : super(kVersions.last.size);

  static _DatabaseReferencePushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferencePushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferencePushParams result = new _DatabaseReferencePushParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.child = decoder0.decodeInterfaceRequest(16, false, DatabaseReferenceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferencePushParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(child, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "child of struct _DatabaseReferencePushParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferencePushParams("
           "path: $path" ", "
           "child: $child" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DatabaseReferencePushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String key = null;

  DatabaseReferencePushResponseParams() : super(kVersions.last.size);

  static DatabaseReferencePushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DatabaseReferencePushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DatabaseReferencePushResponseParams result = new DatabaseReferencePushResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.key = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(key, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "key of struct DatabaseReferencePushResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DatabaseReferencePushResponseParams("
           "key: $key" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["key"] = key;
    return map;
  }
}


class _DatabaseReferenceSetPriorityParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String path = null;
  int priority = 0;

  _DatabaseReferenceSetPriorityParams() : super(kVersions.last.size);

  static _DatabaseReferenceSetPriorityParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DatabaseReferenceSetPriorityParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DatabaseReferenceSetPriorityParams result = new _DatabaseReferenceSetPriorityParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.path = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.priority = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(path, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _DatabaseReferenceSetPriorityParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(priority, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "priority of struct _DatabaseReferenceSetPriorityParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DatabaseReferenceSetPriorityParams("
           "path: $path" ", "
           "priority: $priority" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["path"] = path;
    map["priority"] = priority;
    return map;
  }
}


class DatabaseReferenceSetPriorityResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  DatabaseReferenceSetPriorityResponseParams() : super(kVersions.last.size);

  static DatabaseReferenceSetPriorityResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DatabaseReferenceSetPriorityResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DatabaseReferenceSetPriorityResponseParams result = new DatabaseReferenceSetPriorityResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct DatabaseReferenceSetPriorityResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DatabaseReferenceSetPriorityResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FirebaseConfigureParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FirebaseConfigureParams() : super(kVersions.last.size);

  static _FirebaseConfigureParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FirebaseConfigureParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FirebaseConfigureParams result = new _FirebaseConfigureParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_FirebaseConfigureParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _FirebaseReferenceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DatabaseReferenceInterfaceRequest result = null;

  _FirebaseReferenceParams() : super(kVersions.last.size);

  static _FirebaseReferenceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FirebaseReferenceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FirebaseReferenceParams result = new _FirebaseReferenceParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.result = decoder0.decodeInterfaceRequest(8, false, DatabaseReferenceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct _FirebaseReferenceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FirebaseReferenceParams("
           "result: $result" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FirebaseSignInAnonymouslyParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FirebaseSignInAnonymouslyParams() : super(kVersions.last.size);

  static _FirebaseSignInAnonymouslyParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FirebaseSignInAnonymouslyParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FirebaseSignInAnonymouslyParams result = new _FirebaseSignInAnonymouslyParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_FirebaseSignInAnonymouslyParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FirebaseSignInAnonymouslyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  User user = null;
  Error error = null;

  FirebaseSignInAnonymouslyResponseParams() : super(kVersions.last.size);

  static FirebaseSignInAnonymouslyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FirebaseSignInAnonymouslyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FirebaseSignInAnonymouslyResponseParams result = new FirebaseSignInAnonymouslyResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.user = User.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(user, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "user of struct FirebaseSignInAnonymouslyResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FirebaseSignInAnonymouslyResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FirebaseSignInAnonymouslyResponseParams("
           "user: $user" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["user"] = user;
    map["error"] = error;
    return map;
  }
}


class _FirebaseSignOutParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FirebaseSignOutParams() : super(kVersions.last.size);

  static _FirebaseSignOutParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FirebaseSignOutParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FirebaseSignOutParams result = new _FirebaseSignOutParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_FirebaseSignOutParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FirebaseSignOutResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Error error = null;

  FirebaseSignOutResponseParams() : super(kVersions.last.size);

  static FirebaseSignOutResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FirebaseSignOutResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FirebaseSignOutResponseParams result = new FirebaseSignOutResponseParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = Error.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FirebaseSignOutResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FirebaseSignOutResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FirebaseLogCrashParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String message = null;

  _FirebaseLogCrashParams() : super(kVersions.last.size);

  static _FirebaseLogCrashParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FirebaseLogCrashParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FirebaseLogCrashParams result = new _FirebaseLogCrashParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.message = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(message, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "message of struct _FirebaseLogCrashParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FirebaseLogCrashParams("
           "message: $message" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    return map;
  }
}

const int _valueEventListenerMethodOnCancelledName = 0;
const int _valueEventListenerMethodOnDataChangeName = 1;

class _ValueEventListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ValueEventListener {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ValueEventListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ValueEventListenerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ValueEventListenerProxy p = new ValueEventListenerProxy.unbound();
    String name = serviceName ?? ValueEventListener.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void onCancelled(Error error);
  void onDataChange(DataSnapshot snapshot);
}

abstract class ValueEventListenerInterface
    implements bindings.MojoInterface<ValueEventListener>,
               ValueEventListener {
  factory ValueEventListenerInterface([ValueEventListener impl]) =>
      new ValueEventListenerStub.unbound(impl);
  factory ValueEventListenerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ValueEventListener impl]) =>
      new ValueEventListenerStub.fromEndpoint(endpoint, impl);
}

abstract class ValueEventListenerInterfaceRequest
    implements bindings.MojoInterface<ValueEventListener>,
               ValueEventListener {
  factory ValueEventListenerInterfaceRequest() =>
      new ValueEventListenerProxy.unbound();
}

class _ValueEventListenerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ValueEventListener> {
  _ValueEventListenerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ValueEventListenerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ValueEventListenerProxyControl.unbound() : super.unbound();

  String get serviceName => ValueEventListener.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  ValueEventListener get impl => null;
  set impl(ValueEventListener _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ValueEventListenerProxyControl($superString)";
  }
}

class ValueEventListenerProxy
    extends bindings.Proxy<ValueEventListener>
    implements ValueEventListener,
               ValueEventListenerInterface,
               ValueEventListenerInterfaceRequest {
  ValueEventListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ValueEventListenerProxyControl.fromEndpoint(endpoint));

  ValueEventListenerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ValueEventListenerProxyControl.fromHandle(handle));

  ValueEventListenerProxy.unbound()
      : super(new _ValueEventListenerProxyControl.unbound());

  static ValueEventListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ValueEventListenerProxy"));
    return new ValueEventListenerProxy.fromEndpoint(endpoint);
  }


  void onCancelled(Error error) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ValueEventListenerOnCancelledParams();
    params.error = error;
    ctrl.sendMessage(params,
        _valueEventListenerMethodOnCancelledName);
  }
  void onDataChange(DataSnapshot snapshot) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ValueEventListenerOnDataChangeParams();
    params.snapshot = snapshot;
    ctrl.sendMessage(params,
        _valueEventListenerMethodOnDataChangeName);
  }
}

class _ValueEventListenerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ValueEventListener> {
  ValueEventListener _impl;

  _ValueEventListenerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ValueEventListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ValueEventListenerStubControl.fromHandle(
      core.MojoHandle handle, [ValueEventListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ValueEventListenerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ValueEventListener.serviceName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _valueEventListenerMethodOnCancelledName:
        var params = _ValueEventListenerOnCancelledParams.deserialize(
            message.payload);
        _impl.onCancelled(params.error);
        break;
      case _valueEventListenerMethodOnDataChangeName:
        var params = _ValueEventListenerOnDataChangeParams.deserialize(
            message.payload);
        _impl.onDataChange(params.snapshot);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ValueEventListener get impl => _impl;
  set impl(ValueEventListener d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ValueEventListenerStubControl($superString)";
  }

  int get version => 0;
}

class ValueEventListenerStub
    extends bindings.Stub<ValueEventListener>
    implements ValueEventListener,
               ValueEventListenerInterface,
               ValueEventListenerInterfaceRequest {
  ValueEventListenerStub.unbound([ValueEventListener impl])
      : super(new _ValueEventListenerStubControl.unbound(impl));

  ValueEventListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ValueEventListener impl])
      : super(new _ValueEventListenerStubControl.fromEndpoint(endpoint, impl));

  ValueEventListenerStub.fromHandle(
      core.MojoHandle handle, [ValueEventListener impl])
      : super(new _ValueEventListenerStubControl.fromHandle(handle, impl));

  static ValueEventListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ValueEventListenerStub"));
    return new ValueEventListenerStub.fromEndpoint(endpoint);
  }


  void onCancelled(Error error) {
    return impl.onCancelled(error);
  }
  void onDataChange(DataSnapshot snapshot) {
    return impl.onDataChange(snapshot);
  }
}

const int _childEventListenerMethodOnCancelledName = 0;
const int _childEventListenerMethodOnChildAddedName = 1;
const int _childEventListenerMethodOnChildChangedName = 2;
const int _childEventListenerMethodOnChildMovedName = 3;
const int _childEventListenerMethodOnChildRemovedName = 4;

class _ChildEventListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ChildEventListener {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ChildEventListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ChildEventListenerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ChildEventListenerProxy p = new ChildEventListenerProxy.unbound();
    String name = serviceName ?? ChildEventListener.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void onCancelled(Error error);
  void onChildAdded(DataSnapshot snapshot, String previousChildName);
  void onChildChanged(DataSnapshot snapshot, String previousChildName);
  void onChildMoved(DataSnapshot snapshot, String previousChildName);
  void onChildRemoved(DataSnapshot snapshot);
}

abstract class ChildEventListenerInterface
    implements bindings.MojoInterface<ChildEventListener>,
               ChildEventListener {
  factory ChildEventListenerInterface([ChildEventListener impl]) =>
      new ChildEventListenerStub.unbound(impl);
  factory ChildEventListenerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ChildEventListener impl]) =>
      new ChildEventListenerStub.fromEndpoint(endpoint, impl);
}

abstract class ChildEventListenerInterfaceRequest
    implements bindings.MojoInterface<ChildEventListener>,
               ChildEventListener {
  factory ChildEventListenerInterfaceRequest() =>
      new ChildEventListenerProxy.unbound();
}

class _ChildEventListenerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ChildEventListener> {
  _ChildEventListenerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ChildEventListenerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ChildEventListenerProxyControl.unbound() : super.unbound();

  String get serviceName => ChildEventListener.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  ChildEventListener get impl => null;
  set impl(ChildEventListener _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ChildEventListenerProxyControl($superString)";
  }
}

class ChildEventListenerProxy
    extends bindings.Proxy<ChildEventListener>
    implements ChildEventListener,
               ChildEventListenerInterface,
               ChildEventListenerInterfaceRequest {
  ChildEventListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ChildEventListenerProxyControl.fromEndpoint(endpoint));

  ChildEventListenerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ChildEventListenerProxyControl.fromHandle(handle));

  ChildEventListenerProxy.unbound()
      : super(new _ChildEventListenerProxyControl.unbound());

  static ChildEventListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ChildEventListenerProxy"));
    return new ChildEventListenerProxy.fromEndpoint(endpoint);
  }


  void onCancelled(Error error) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ChildEventListenerOnCancelledParams();
    params.error = error;
    ctrl.sendMessage(params,
        _childEventListenerMethodOnCancelledName);
  }
  void onChildAdded(DataSnapshot snapshot, String previousChildName) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ChildEventListenerOnChildAddedParams();
    params.snapshot = snapshot;
    params.previousChildName = previousChildName;
    ctrl.sendMessage(params,
        _childEventListenerMethodOnChildAddedName);
  }
  void onChildChanged(DataSnapshot snapshot, String previousChildName) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ChildEventListenerOnChildChangedParams();
    params.snapshot = snapshot;
    params.previousChildName = previousChildName;
    ctrl.sendMessage(params,
        _childEventListenerMethodOnChildChangedName);
  }
  void onChildMoved(DataSnapshot snapshot, String previousChildName) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ChildEventListenerOnChildMovedParams();
    params.snapshot = snapshot;
    params.previousChildName = previousChildName;
    ctrl.sendMessage(params,
        _childEventListenerMethodOnChildMovedName);
  }
  void onChildRemoved(DataSnapshot snapshot) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ChildEventListenerOnChildRemovedParams();
    params.snapshot = snapshot;
    ctrl.sendMessage(params,
        _childEventListenerMethodOnChildRemovedName);
  }
}

class _ChildEventListenerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ChildEventListener> {
  ChildEventListener _impl;

  _ChildEventListenerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ChildEventListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ChildEventListenerStubControl.fromHandle(
      core.MojoHandle handle, [ChildEventListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ChildEventListenerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ChildEventListener.serviceName;



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _childEventListenerMethodOnCancelledName:
        var params = _ChildEventListenerOnCancelledParams.deserialize(
            message.payload);
        _impl.onCancelled(params.error);
        break;
      case _childEventListenerMethodOnChildAddedName:
        var params = _ChildEventListenerOnChildAddedParams.deserialize(
            message.payload);
        _impl.onChildAdded(params.snapshot, params.previousChildName);
        break;
      case _childEventListenerMethodOnChildChangedName:
        var params = _ChildEventListenerOnChildChangedParams.deserialize(
            message.payload);
        _impl.onChildChanged(params.snapshot, params.previousChildName);
        break;
      case _childEventListenerMethodOnChildMovedName:
        var params = _ChildEventListenerOnChildMovedParams.deserialize(
            message.payload);
        _impl.onChildMoved(params.snapshot, params.previousChildName);
        break;
      case _childEventListenerMethodOnChildRemovedName:
        var params = _ChildEventListenerOnChildRemovedParams.deserialize(
            message.payload);
        _impl.onChildRemoved(params.snapshot);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ChildEventListener get impl => _impl;
  set impl(ChildEventListener d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ChildEventListenerStubControl($superString)";
  }

  int get version => 0;
}

class ChildEventListenerStub
    extends bindings.Stub<ChildEventListener>
    implements ChildEventListener,
               ChildEventListenerInterface,
               ChildEventListenerInterfaceRequest {
  ChildEventListenerStub.unbound([ChildEventListener impl])
      : super(new _ChildEventListenerStubControl.unbound(impl));

  ChildEventListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ChildEventListener impl])
      : super(new _ChildEventListenerStubControl.fromEndpoint(endpoint, impl));

  ChildEventListenerStub.fromHandle(
      core.MojoHandle handle, [ChildEventListener impl])
      : super(new _ChildEventListenerStubControl.fromHandle(handle, impl));

  static ChildEventListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ChildEventListenerStub"));
    return new ChildEventListenerStub.fromEndpoint(endpoint);
  }


  void onCancelled(Error error) {
    return impl.onCancelled(error);
  }
  void onChildAdded(DataSnapshot snapshot, String previousChildName) {
    return impl.onChildAdded(snapshot, previousChildName);
  }
  void onChildChanged(DataSnapshot snapshot, String previousChildName) {
    return impl.onChildChanged(snapshot, previousChildName);
  }
  void onChildMoved(DataSnapshot snapshot, String previousChildName) {
    return impl.onChildMoved(snapshot, previousChildName);
  }
  void onChildRemoved(DataSnapshot snapshot) {
    return impl.onChildRemoved(snapshot);
  }
}

const int _databaseReferenceMethodAddValueEventListenerName = 0;
const int _databaseReferenceMethodAddChildEventListenerName = 1;
const int _databaseReferenceMethodObserveSingleEventOfTypeName = 2;
const int _databaseReferenceMethodSetValueName = 3;
const int _databaseReferenceMethodRemoveValueName = 4;
const int _databaseReferenceMethodPushName = 5;
const int _databaseReferenceMethodSetPriorityName = 6;

class _DatabaseReferenceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class DatabaseReference {
  static const String serviceName = "firebase::DatabaseReference";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _DatabaseReferenceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static DatabaseReferenceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DatabaseReferenceProxy p = new DatabaseReferenceProxy.unbound();
    String name = serviceName ?? DatabaseReference.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void addValueEventListener(String path, ValueEventListenerInterface listener);
  void addChildEventListener(String path, ChildEventListenerInterface listener);
  dynamic observeSingleEventOfType(String path,EventType eventType,[Function responseFactory = null]);
  dynamic setValue(String path,String jsonValue,int priority,bool hasPriority,[Function responseFactory = null]);
  dynamic removeValue(String path,[Function responseFactory = null]);
  dynamic push(String path,DatabaseReferenceInterfaceRequest child,[Function responseFactory = null]);
  dynamic setPriority(String path,int priority,[Function responseFactory = null]);
}

abstract class DatabaseReferenceInterface
    implements bindings.MojoInterface<DatabaseReference>,
               DatabaseReference {
  factory DatabaseReferenceInterface([DatabaseReference impl]) =>
      new DatabaseReferenceStub.unbound(impl);
  factory DatabaseReferenceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [DatabaseReference impl]) =>
      new DatabaseReferenceStub.fromEndpoint(endpoint, impl);
}

abstract class DatabaseReferenceInterfaceRequest
    implements bindings.MojoInterface<DatabaseReference>,
               DatabaseReference {
  factory DatabaseReferenceInterfaceRequest() =>
      new DatabaseReferenceProxy.unbound();
}

class _DatabaseReferenceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<DatabaseReference> {
  _DatabaseReferenceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DatabaseReferenceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _DatabaseReferenceProxyControl.unbound() : super.unbound();

  String get serviceName => DatabaseReference.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _databaseReferenceMethodObserveSingleEventOfTypeName:
        var r = DatabaseReferenceObserveSingleEventOfTypeResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _databaseReferenceMethodSetValueName:
        var r = DatabaseReferenceSetValueResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _databaseReferenceMethodRemoveValueName:
        var r = DatabaseReferenceRemoveValueResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _databaseReferenceMethodPushName:
        var r = DatabaseReferencePushResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _databaseReferenceMethodSetPriorityName:
        var r = DatabaseReferenceSetPriorityResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  DatabaseReference get impl => null;
  set impl(DatabaseReference _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_DatabaseReferenceProxyControl($superString)";
  }
}

class DatabaseReferenceProxy
    extends bindings.Proxy<DatabaseReference>
    implements DatabaseReference,
               DatabaseReferenceInterface,
               DatabaseReferenceInterfaceRequest {
  DatabaseReferenceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _DatabaseReferenceProxyControl.fromEndpoint(endpoint));

  DatabaseReferenceProxy.fromHandle(core.MojoHandle handle)
      : super(new _DatabaseReferenceProxyControl.fromHandle(handle));

  DatabaseReferenceProxy.unbound()
      : super(new _DatabaseReferenceProxyControl.unbound());

  static DatabaseReferenceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DatabaseReferenceProxy"));
    return new DatabaseReferenceProxy.fromEndpoint(endpoint);
  }


  void addValueEventListener(String path, ValueEventListenerInterface listener) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _DatabaseReferenceAddValueEventListenerParams();
    params.path = path;
    params.listener = listener;
    ctrl.sendMessage(params,
        _databaseReferenceMethodAddValueEventListenerName);
  }
  void addChildEventListener(String path, ChildEventListenerInterface listener) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _DatabaseReferenceAddChildEventListenerParams();
    params.path = path;
    params.listener = listener;
    ctrl.sendMessage(params,
        _databaseReferenceMethodAddChildEventListenerName);
  }
  dynamic observeSingleEventOfType(String path,EventType eventType,[Function responseFactory = null]) {
    var params = new _DatabaseReferenceObserveSingleEventOfTypeParams();
    params.path = path;
    params.eventType = eventType;
    return ctrl.sendMessageWithRequestId(
        params,
        _databaseReferenceMethodObserveSingleEventOfTypeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setValue(String path,String jsonValue,int priority,bool hasPriority,[Function responseFactory = null]) {
    var params = new _DatabaseReferenceSetValueParams();
    params.path = path;
    params.jsonValue = jsonValue;
    params.priority = priority;
    params.hasPriority = hasPriority;
    return ctrl.sendMessageWithRequestId(
        params,
        _databaseReferenceMethodSetValueName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic removeValue(String path,[Function responseFactory = null]) {
    var params = new _DatabaseReferenceRemoveValueParams();
    params.path = path;
    return ctrl.sendMessageWithRequestId(
        params,
        _databaseReferenceMethodRemoveValueName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic push(String path,DatabaseReferenceInterfaceRequest child,[Function responseFactory = null]) {
    var params = new _DatabaseReferencePushParams();
    params.path = path;
    params.child = child;
    return ctrl.sendMessageWithRequestId(
        params,
        _databaseReferenceMethodPushName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setPriority(String path,int priority,[Function responseFactory = null]) {
    var params = new _DatabaseReferenceSetPriorityParams();
    params.path = path;
    params.priority = priority;
    return ctrl.sendMessageWithRequestId(
        params,
        _databaseReferenceMethodSetPriorityName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _DatabaseReferenceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<DatabaseReference> {
  DatabaseReference _impl;

  _DatabaseReferenceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DatabaseReference impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _DatabaseReferenceStubControl.fromHandle(
      core.MojoHandle handle, [DatabaseReference impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _DatabaseReferenceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => DatabaseReference.serviceName;


  DatabaseReferenceObserveSingleEventOfTypeResponseParams _databaseReferenceObserveSingleEventOfTypeResponseParamsFactory(DataSnapshot snapshot) {
    var result = new DatabaseReferenceObserveSingleEventOfTypeResponseParams();
    result.snapshot = snapshot;
    return result;
  }
  DatabaseReferenceSetValueResponseParams _databaseReferenceSetValueResponseParamsFactory(Error error) {
    var result = new DatabaseReferenceSetValueResponseParams();
    result.error = error;
    return result;
  }
  DatabaseReferenceRemoveValueResponseParams _databaseReferenceRemoveValueResponseParamsFactory(Error error) {
    var result = new DatabaseReferenceRemoveValueResponseParams();
    result.error = error;
    return result;
  }
  DatabaseReferencePushResponseParams _databaseReferencePushResponseParamsFactory(String key) {
    var result = new DatabaseReferencePushResponseParams();
    result.key = key;
    return result;
  }
  DatabaseReferenceSetPriorityResponseParams _databaseReferenceSetPriorityResponseParamsFactory(Error error) {
    var result = new DatabaseReferenceSetPriorityResponseParams();
    result.error = error;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _databaseReferenceMethodAddValueEventListenerName:
        var params = _DatabaseReferenceAddValueEventListenerParams.deserialize(
            message.payload);
        _impl.addValueEventListener(params.path, params.listener);
        break;
      case _databaseReferenceMethodAddChildEventListenerName:
        var params = _DatabaseReferenceAddChildEventListenerParams.deserialize(
            message.payload);
        _impl.addChildEventListener(params.path, params.listener);
        break;
      case _databaseReferenceMethodObserveSingleEventOfTypeName:
        var params = _DatabaseReferenceObserveSingleEventOfTypeParams.deserialize(
            message.payload);
        var response = _impl.observeSingleEventOfType(params.path,params.eventType,_databaseReferenceObserveSingleEventOfTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _databaseReferenceMethodObserveSingleEventOfTypeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _databaseReferenceMethodObserveSingleEventOfTypeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _databaseReferenceMethodSetValueName:
        var params = _DatabaseReferenceSetValueParams.deserialize(
            message.payload);
        var response = _impl.setValue(params.path,params.jsonValue,params.priority,params.hasPriority,_databaseReferenceSetValueResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _databaseReferenceMethodSetValueName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _databaseReferenceMethodSetValueName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _databaseReferenceMethodRemoveValueName:
        var params = _DatabaseReferenceRemoveValueParams.deserialize(
            message.payload);
        var response = _impl.removeValue(params.path,_databaseReferenceRemoveValueResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _databaseReferenceMethodRemoveValueName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _databaseReferenceMethodRemoveValueName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _databaseReferenceMethodPushName:
        var params = _DatabaseReferencePushParams.deserialize(
            message.payload);
        var response = _impl.push(params.path,params.child,_databaseReferencePushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _databaseReferenceMethodPushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _databaseReferenceMethodPushName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _databaseReferenceMethodSetPriorityName:
        var params = _DatabaseReferenceSetPriorityParams.deserialize(
            message.payload);
        var response = _impl.setPriority(params.path,params.priority,_databaseReferenceSetPriorityResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _databaseReferenceMethodSetPriorityName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _databaseReferenceMethodSetPriorityName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  DatabaseReference get impl => _impl;
  set impl(DatabaseReference d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_DatabaseReferenceStubControl($superString)";
  }

  int get version => 0;
}

class DatabaseReferenceStub
    extends bindings.Stub<DatabaseReference>
    implements DatabaseReference,
               DatabaseReferenceInterface,
               DatabaseReferenceInterfaceRequest {
  DatabaseReferenceStub.unbound([DatabaseReference impl])
      : super(new _DatabaseReferenceStubControl.unbound(impl));

  DatabaseReferenceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DatabaseReference impl])
      : super(new _DatabaseReferenceStubControl.fromEndpoint(endpoint, impl));

  DatabaseReferenceStub.fromHandle(
      core.MojoHandle handle, [DatabaseReference impl])
      : super(new _DatabaseReferenceStubControl.fromHandle(handle, impl));

  static DatabaseReferenceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DatabaseReferenceStub"));
    return new DatabaseReferenceStub.fromEndpoint(endpoint);
  }


  void addValueEventListener(String path, ValueEventListenerInterface listener) {
    return impl.addValueEventListener(path, listener);
  }
  void addChildEventListener(String path, ChildEventListenerInterface listener) {
    return impl.addChildEventListener(path, listener);
  }
  dynamic observeSingleEventOfType(String path,EventType eventType,[Function responseFactory = null]) {
    return impl.observeSingleEventOfType(path,eventType,responseFactory);
  }
  dynamic setValue(String path,String jsonValue,int priority,bool hasPriority,[Function responseFactory = null]) {
    return impl.setValue(path,jsonValue,priority,hasPriority,responseFactory);
  }
  dynamic removeValue(String path,[Function responseFactory = null]) {
    return impl.removeValue(path,responseFactory);
  }
  dynamic push(String path,DatabaseReferenceInterfaceRequest child,[Function responseFactory = null]) {
    return impl.push(path,child,responseFactory);
  }
  dynamic setPriority(String path,int priority,[Function responseFactory = null]) {
    return impl.setPriority(path,priority,responseFactory);
  }
}

const int _firebaseMethodConfigureName = 0;
const int _firebaseMethodReferenceName = 1;
const int _firebaseMethodSignInAnonymouslyName = 2;
const int _firebaseMethodSignOutName = 3;
const int _firebaseMethodLogCrashName = 4;

class _FirebaseServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Firebase {
  static const String serviceName = "firebase::Firebase";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FirebaseServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static FirebaseProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FirebaseProxy p = new FirebaseProxy.unbound();
    String name = serviceName ?? Firebase.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void configure();
  void reference(DatabaseReferenceInterfaceRequest result);
  dynamic signInAnonymously([Function responseFactory = null]);
  dynamic signOut([Function responseFactory = null]);
  void logCrash(String message);
}

abstract class FirebaseInterface
    implements bindings.MojoInterface<Firebase>,
               Firebase {
  factory FirebaseInterface([Firebase impl]) =>
      new FirebaseStub.unbound(impl);
  factory FirebaseInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Firebase impl]) =>
      new FirebaseStub.fromEndpoint(endpoint, impl);
}

abstract class FirebaseInterfaceRequest
    implements bindings.MojoInterface<Firebase>,
               Firebase {
  factory FirebaseInterfaceRequest() =>
      new FirebaseProxy.unbound();
}

class _FirebaseProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Firebase> {
  _FirebaseProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FirebaseProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _FirebaseProxyControl.unbound() : super.unbound();

  String get serviceName => Firebase.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _firebaseMethodSignInAnonymouslyName:
        var r = FirebaseSignInAnonymouslyResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      case _firebaseMethodSignOutName:
        var r = FirebaseSignOutResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  Firebase get impl => null;
  set impl(Firebase _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_FirebaseProxyControl($superString)";
  }
}

class FirebaseProxy
    extends bindings.Proxy<Firebase>
    implements Firebase,
               FirebaseInterface,
               FirebaseInterfaceRequest {
  FirebaseProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _FirebaseProxyControl.fromEndpoint(endpoint));

  FirebaseProxy.fromHandle(core.MojoHandle handle)
      : super(new _FirebaseProxyControl.fromHandle(handle));

  FirebaseProxy.unbound()
      : super(new _FirebaseProxyControl.unbound());

  static FirebaseProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FirebaseProxy"));
    return new FirebaseProxy.fromEndpoint(endpoint);
  }


  void configure() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _FirebaseConfigureParams();
    ctrl.sendMessage(params,
        _firebaseMethodConfigureName);
  }
  void reference(DatabaseReferenceInterfaceRequest result) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _FirebaseReferenceParams();
    params.result = result;
    ctrl.sendMessage(params,
        _firebaseMethodReferenceName);
  }
  dynamic signInAnonymously([Function responseFactory = null]) {
    var params = new _FirebaseSignInAnonymouslyParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _firebaseMethodSignInAnonymouslyName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic signOut([Function responseFactory = null]) {
    var params = new _FirebaseSignOutParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _firebaseMethodSignOutName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void logCrash(String message) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _FirebaseLogCrashParams();
    params.message = message;
    ctrl.sendMessage(params,
        _firebaseMethodLogCrashName);
  }
}

class _FirebaseStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Firebase> {
  Firebase _impl;

  _FirebaseStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Firebase impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _FirebaseStubControl.fromHandle(
      core.MojoHandle handle, [Firebase impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _FirebaseStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Firebase.serviceName;


  FirebaseSignInAnonymouslyResponseParams _firebaseSignInAnonymouslyResponseParamsFactory(User user, Error error) {
    var result = new FirebaseSignInAnonymouslyResponseParams();
    result.user = user;
    result.error = error;
    return result;
  }
  FirebaseSignOutResponseParams _firebaseSignOutResponseParamsFactory(Error error) {
    var result = new FirebaseSignOutResponseParams();
    result.error = error;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _firebaseMethodConfigureName:
        _impl.configure();
        break;
      case _firebaseMethodReferenceName:
        var params = _FirebaseReferenceParams.deserialize(
            message.payload);
        _impl.reference(params.result);
        break;
      case _firebaseMethodSignInAnonymouslyName:
        var response = _impl.signInAnonymously(_firebaseSignInAnonymouslyResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _firebaseMethodSignInAnonymouslyName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _firebaseMethodSignInAnonymouslyName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _firebaseMethodSignOutName:
        var response = _impl.signOut(_firebaseSignOutResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _firebaseMethodSignOutName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _firebaseMethodSignOutName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _firebaseMethodLogCrashName:
        var params = _FirebaseLogCrashParams.deserialize(
            message.payload);
        _impl.logCrash(params.message);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Firebase get impl => _impl;
  set impl(Firebase d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_FirebaseStubControl($superString)";
  }

  int get version => 0;
}

class FirebaseStub
    extends bindings.Stub<Firebase>
    implements Firebase,
               FirebaseInterface,
               FirebaseInterfaceRequest {
  FirebaseStub.unbound([Firebase impl])
      : super(new _FirebaseStubControl.unbound(impl));

  FirebaseStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Firebase impl])
      : super(new _FirebaseStubControl.fromEndpoint(endpoint, impl));

  FirebaseStub.fromHandle(
      core.MojoHandle handle, [Firebase impl])
      : super(new _FirebaseStubControl.fromHandle(handle, impl));

  static FirebaseStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FirebaseStub"));
    return new FirebaseStub.fromEndpoint(endpoint);
  }


  void configure() {
    return impl.configure();
  }
  void reference(DatabaseReferenceInterfaceRequest result) {
    return impl.reference(result);
  }
  dynamic signInAnonymously([Function responseFactory = null]) {
    return impl.signInAnonymously(responseFactory);
  }
  dynamic signOut([Function responseFactory = null]) {
    return impl.signOut(responseFactory);
  }
  void logCrash(String message) {
    return impl.logCrash(message);
  }
}



