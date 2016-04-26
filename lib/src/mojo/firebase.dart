library firebase.mojo.firebase;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sky_services/firebase/firebase.mojom.dart' as mojo;

import '../firebase.dart';
import '../disconnect.dart';
import '../event.dart';
import '../data_snapshot.dart';
import '../transaction_result.dart';

import 'auth_response.dart';
import 'data_snapshot.dart';

class FirebaseImpl extends MojoFirebase {
  factory FirebaseImpl({
    String databaseUrl,
    String googleAppId,
    String androidClientId,
    String clientId,
    String apiKey
  }) {
    return new MojoFirebase(
      databaseUrl: databaseUrl,
      googleAppId: googleAppId,
      androidClientId: androidClientId,
      clientId: clientId,
      apiKey: apiKey
    );
  }
  static final ServerValue = null;
}

class MojoFirebase extends MojoQuery implements Firebase {
  MojoFirebase({
    this.databaseUrl,
    this.googleAppId,
    this.androidClientId,
    this.clientId,
    this.apiKey
  }) : _path = <String>[];

  MojoFirebase._withProxy(mojo.FirebaseProxy firebase, this._path)
    : super._withProxy(firebase);

  final String databaseUrl;
  final String googleAppId;
  final String androidClientId;
  final String clientId;
  final String apiKey;

  // We have to keep track of our full path because we might be asked to provide
  // our key synchronously, and we might also be asked to create our parent
  // and the parent would also need to be able to provide its key synchronously.
  // In some cases we might have a null path if we are an autogenerated
  // child and the call to push() hasn't returned yet. Clients can guard against
  // this by using an onComplete handler before interrogating autogenerated
  // nodes for their key.
  List<String> _path;

  Disconnect get onDisconnect => null;

  @deprecated
  Future auth(String token) => null;

  Future authWithCustomToken(String token) {
    Completer completer = new Completer();
    _firebase.ptr.authWithCustomToken(token).then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authAnonymously({remember: 'default'}) {
    Completer completer = new Completer();
    _firebase.ptr.authAnonymously().then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authWithPassword(Map credentials) {
    Completer completer = new Completer();
    _firebase.ptr
      .authWithPassword(credentials["email"], credentials["password"])
      .then(_getAuthCallback(completer));
    return completer.future;
  }

  Future authWithOAuthPopup(provider, {remember: 'default', scope: ''}) {
    throw new UnsupportedError("$runtimeType.authWithOAuthPopup");
  }

  Future authWithOAuthRedirect(provider, {remember: 'default', scope: ''}) {
    throw new UnsupportedError("$runtimeType.authWithOAuthRedirect");
  }

  Future authWithOAuthToken(String provider, String credentials,
      {remember: 'default', scope: ''}) {
    // The remember and scope arguments are intentionally ignored
    Completer completer = new Completer();
    _firebase.ptr
      .authWithOAuthToken(provider, credentials)
      .then(_getAuthCallback(completer));
    return completer.future;
  }

  Function _getAuthCallback(Completer completer) {
    return (response) {
      if (response.error != null) {
        completer.completeError(response.error);
      } else {
        completer.complete(decodeAuthData(response.authData));
      }
    };
  }

  Function _getResultCallback(Completer completer) {
    return (response) {
      if (response.error != null) {
        completer.completeError(response.error);
      } else {
        completer.complete();
      }
    };
  }

  dynamic getAuth() => throw new UnimplementedError();

  Stream onAuth([context]) => throw new UnimplementedError();

  void unauth() {
    _firebase.ptr.unauth();
  }

  Firebase child(String path) {
    mojo.FirebaseProxy proxy = new mojo.FirebaseProxy.unbound();
    _firebase.ptr.getChild(path, proxy);
    return new MojoFirebase._withProxy(
      proxy,
      new List<String>.from(_path)..addAll(path.split("/"))
    );
  }

  Firebase parent() {
    mojo.FirebaseProxy proxy = new mojo.FirebaseProxy.unbound();
    _firebase.ptr.getParent(proxy);
    return new MojoFirebase._withProxy(
      proxy,
      new List<String>.from(_path)..removeLast()
    );
  }

  Firebase root() {
    mojo.FirebaseProxy proxy = new mojo.FirebaseProxy.unbound();
    _firebase.ptr.getRoot(proxy);
    return new MojoFirebase._withProxy(proxy, <String>[]);
  }

  String get key {
    if (_path != null)
      return _path.join("/");
    throw new UnsupportedError("Autogenerated child key is not available yet");
  }

  String toString() => "$runtimeType($key)";

  Future set(value) => setWithPriority(value, null);

  Future update(Map<String, dynamic> value) => null;

  Future remove() {
    Completer completer = new Completer();
    _firebase.ptr
      .removeValue()
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Firebase push({value, onComplete}) {
    mojo.FirebaseProxy proxy = new mojo.FirebaseProxy.unbound();
    MojoFirebase child = new MojoFirebase._withProxy(proxy, null);
    Future<String> getKey = _firebase.ptr.push(proxy);
    Future<mojo.Error> setValue = child.set(value);
    Future.wait([getKey, setValue])
      .then((List responses) {
        mojo.FirebasePushResponseParams response = responses[0];
        mojo.Error error = responses[1];
        child._path = new List<String>.from(_path)..add(response.key);
        if (onComplete != null)
          onComplete(error);
      });
    return child;
  }

  Future setWithPriority(value, int priority) {
    Completer completer = new Completer();
    String jsonValue = JSON.encode({ "value": value });
    _firebase
      .ptr.setValue(jsonValue, priority ?? 0, priority != null)
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Future setPriority(int priority) {
    Completer completer = new Completer();
    _firebase.ptr
      .setPriority(priority)
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Future<TransactionResult> transaction(update(currentVal),
      {bool applyLocally: true}) => new Future.value(throw new UnimplementedError());

  Future createUser(Map credentials) {
    Completer completer = new Completer();
    _firebase
      .ptr.createUser(credentials['email'], credentials['password'])
      .then((mojo.FirebaseCreateUserResponseParams response) {
        if (response.error != null) {
          completer.completeError(response.error);
        } else {
          completer.complete(JSON.decode(response.jsonValue));
        }
      });
    return completer.future;
  }

  Future changeEmail(Map credentials) {
    Completer completer = new Completer();
    _firebase
      .ptr.changeEmail(
        credentials['oldEmail'],
        credentials['password'],
        credentials['newEmail'])
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Future changePassword(Map credentials) {
    Completer completer = new Completer();
    _firebase
      .ptr.changePassword(
        credentials['newPassword'],
        credentials['email'],
        credentials['oldPassword'])
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Future removeUser(Map credentials) {
    Completer completer = new Completer();
    _firebase
      .ptr.removeUser(credentials['email'], credentials['password'])
      .then(_getResultCallback(completer));
    return completer.future;
  }

  Future resetPassword(Map credentials) {
    Completer completer = new Completer();
    _firebase
      .ptr.resetPassword(credentials['email'])
      .then(_getResultCallback(completer));
    return completer.future;
  }
}

class _ValueEventListener implements mojo.ValueEventListener {
  StreamController<Event> _controller;
  _ValueEventListener(this._controller);

  void onCancelled(mojo.Error error) {
    print("ValueEventListener onCancelled: ${error}");
    _controller.close();
  }

  void onDataChange(mojo.DataSnapshot snapshot) {
    Event event = new Event(new MojoDataSnapshot.fromMojoObject(snapshot), null);
    _controller.add(event);
  }
}

class _ChildEvent extends Event {
  _ChildEvent(this.eventType, DataSnapshot snapshot, [ String prevChild ])
    : super(snapshot, prevChild);
  final mojo.EventType eventType;
}

class _ChildEventListener implements mojo.ChildEventListener {
  final StreamController<Event> _controller;
  _ChildEventListener(this._controller);

  void onCancelled(mojo.Error error) {
    print("ChildEventListener onCancelled: ${error}");
    _controller.close();
  }

  void onChildAdded(mojo.DataSnapshot snapshot, String prevSiblingKey) {
    _ChildEvent event = new _ChildEvent(
      mojo.EventType.eventTypeChildAdded,
      new MojoDataSnapshot.fromMojoObject(snapshot),
      prevSiblingKey
    );
    _controller.add(event);
  }

  void onChildMoved(mojo.DataSnapshot snapshot, String prevSiblingKey) {
    _ChildEvent event = new _ChildEvent(
      mojo.EventType.eventTypeChildMoved,
      new MojoDataSnapshot.fromMojoObject(snapshot),
      prevSiblingKey
    );
    _controller.add(event);
  }

  void onChildChanged(mojo.DataSnapshot snapshot, String prevSiblingKey) {
    _ChildEvent event = new _ChildEvent(
      mojo.EventType.eventTypeChildChanged,
      new MojoDataSnapshot.fromMojoObject(snapshot),
      prevSiblingKey
    );
    _controller.add(event);
  }

  void onChildRemoved(mojo.DataSnapshot snapshot) {
    _ChildEvent event = new _ChildEvent(
      mojo.EventType.eventTypeChildRemoved,
      new MojoDataSnapshot.fromMojoObject(snapshot)
    );
    _controller.add(event);
  }
}

class MojoQuery implements Query {
  mojo.FirebaseProxy _firebase;

  MojoQuery(String url) : _firebase = new mojo.FirebaseProxy.unbound() {
    shell.connectToService("firebase::Firebase", _firebase);
    _firebase.ptr.initWithUrl(url);
  }

  MojoQuery._withProxy(mojo.FirebaseProxy firebase) : _firebase = firebase;

  Stream<Event> _onValue;
  Stream<Event> get onValue {
    if (_onValue == null) {
      mojo.ValueEventListener listener;
      mojo.ValueEventListenerStub stub;
      StreamController<Event> controller = new StreamController<Event>.broadcast(
        onListen: () {
          stub = new mojo.ValueEventListenerStub.unbound()..impl = listener;
          _firebase.ptr.addValueEventListener(stub);
        },
        onCancel: () => stub.close(),
        sync: true
      );
      listener = new _ValueEventListener(controller);
      _onValue = controller.stream;
    }
    return _onValue;
  }

  Stream<Event> _onChildEvent;
  Stream<Event> _on(mojo.EventType eventType) {
    if (_onChildEvent == null) {
      mojo.ChildEventListener listener;
      mojo.ChildEventListenerStub stub;
      StreamController<Event> controller = new StreamController<Event>.broadcast(
        onListen: () {
          stub = new mojo.ChildEventListenerStub.unbound()
            ..impl = listener;
          _firebase.ptr.addChildEventListener(stub);
        },
        onCancel: () => stub.close(),
        sync: true
      );
      listener = new _ChildEventListener(controller);
      _onChildEvent = controller.stream;
    }
    return _onChildEvent.where((_ChildEvent event) => event.eventType == eventType);
  }

  Stream<Event> get onChildAdded => _on(mojo.EventType.eventTypeChildAdded);
  Stream<Event> get onChildMoved => _on(mojo.EventType.eventTypeChildMoved);
  Stream<Event> get onChildChanged => _on(mojo.EventType.eventTypeChildChanged);
  Stream<Event> get onChildRemoved => _on(mojo.EventType.eventTypeChildRemoved);

  /**
   * Listens for exactly one event of the specified event type, and then stops
   * listening.
   */
  Future<DataSnapshot> once(String eventType) async {
    mojo.EventType mojoEventType;
    switch(eventType) {
      case "value":
        mojoEventType = mojo.EventType.eventTypeValue;
        break;
      case "child_added":
        mojoEventType = mojo.EventType.eventTypeChildAdded;
        break;
      case "child_changed":
        mojoEventType = mojo.EventType.eventTypeChildChanged;
        break;
      case "child_removed":
        mojoEventType = mojo.EventType.eventTypeChildRemoved;
        break;
      case "child_moved":
        mojoEventType = mojo.EventType.eventTypeChildMoved;
        break;
      default:
        assert(false);
        return null;
    }
    mojo.DataSnapshot result =
      (await _firebase.ptr.observeSingleEventOfType(mojoEventType)).snapshot;
    return new MojoDataSnapshot.fromMojoObject(result);
  }

  /**
   * Generates a new Query object ordered by the specified child key.
   */
  Query orderByChild(String key) => null;

  /**
   * Generates a new Query object ordered by key.
   */
  Query orderByKey() => null;

  /**
   * Generates a new Query object ordered by child values.
   */
  Query orderByValue() => null;

  /**
   * Generates a new Query object ordered by priority.
   */
  Query orderByPriority() => null;

  /**
   * Creates a Query with the specified starting point. The generated Query
   * includes children which match the specified starting point. If no arguments
   * are provided, the starting point will be the beginning of the data.
   *
   * The starting point is inclusive, so children with exactly the specified
   * priority will be included. Though if the optional name is specified, then
   * the children that have exactly the specified priority must also have a
   * name greater than or equal to the specified name.
   *
   * startAt() can be combined with endAt() or limitToFirst() or limitToLast()
   * to create further restrictive queries.
   */
  Query startAt({dynamic value, String key}) => null;

  /**
   * Creates a Query with the specified ending point. The generated Query
   * includes children which match the specified ending point. If no arguments
   * are provided, the ending point will be the end of the data.
   *
   * The ending point is inclusive, so children with exactly the specified
   * priority will be included. Though if the optional name is specified, then
   * children that have exactly the specified priority must also have a name
   * less than or equal to the specified name.
   *
   * endAt() can be combined with startAt() or limitToFirst() or limitToLast()
   * to create further restrictive queries.
   */
  Query endAt({dynamic value, String key}) => null;

  /**
   * Creates a Query which includes children which match the specified value.
   */
  Query equalTo(value, [key]) => null;

  /**
   * Generates a new Query object limited to the first certain number of children.
   */
  Query limitToFirst(int limit) => null;

  /**
   * Generates a new Query object limited to the last certain number of children.
   */
  Query limitToLast(int limit) => null;

  /**
   * Generate a Query object limited to the number of specified children. If
   * combined with startAt, the query will include the specified number of
   * children after the starting point. If combined with endAt, the query will
   * include the specified number of children before the ending point. If not
   * combined with startAt() or endAt(), the query will include the last
   * specified number of children.
   */
  @deprecated
  Query limit(int limit) => null;

  /**
   * Queries are attached to a location in your Firebase. This method will
   * return a Firebase reference to that location.
   */
  Firebase ref() => null;
}
