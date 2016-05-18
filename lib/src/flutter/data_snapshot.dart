library firebase.js.snapshot;

import 'dart:convert';

import '../generated/firebase.mojom.dart' as mojom;

import '../data_snapshot.dart';
import '../database.dart';

/**
 * A DataSnapshot contains data from a Firebase location. Any time you read
 * Firebase data, you receive data as a DataSnapshot.
 *
 * DataSnapshots are passed to event handlers such as onValue or onceValue.
 * You can extract the contents of the snapshot by calling val(), or you
 * can traverse into the snapshot by calling child() to return child
 * snapshots (which you could in turn call val() on).
 */
class FlutterDataSnapshot implements DataSnapshot {
  /**
   * Holds a reference to the Flutter 'DataSnapshot' object.
   */
  final mojom.DataSnapshot _ds;

  /**
   * Construct a new FlutterDataSnapshot from a mojo DataSnapshot.
   */
  FlutterDataSnapshot.fromFlutterObject(mojom.DataSnapshot obj) : _ds = obj;

  bool get exists => true;

  dynamic val() => JSON.decode(_ds.jsonValue)['value'];

  DataSnapshot child(String path) => null;

  void forEach(cb(DataSnapshot snapshot)) { }

  bool hasChild(String path) => false;

  bool get hasChildren => false;

  String get key => _ds.key;

  int get numChildren => null;

  DatabaseReference ref() => null;

  dynamic getPriority() => null;

  dynamic exportVal() => null;
}
