// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.google.firebase.mojo;

import android.content.Context;
import android.util.Log;
import android.content.res.AssetManager;

import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.DatabaseReference.CompletionListener;

import com.google.firebase.mojo.Conversions;

// import com.firebase.client.AuthData;
// import com.firebase.client.FirebaseError;
// import com.firebase.client.Firebase.AuthResultHandler;
// import com.firebase.client.Firebase.CompletionListener;
// import com.firebase.client.Firebase.ResultHandler;
// import com.firebase.client.Firebase.ValueResultHandler;

import java.io.InputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.util.Map;
import java.util.HashMap;

import org.chromium.mojo.bindings.ConnectionErrorHandler;
import org.chromium.mojo.bindings.InterfaceRequest;
import org.chromium.mojo.system.Core;
import org.chromium.mojo.system.MessagePipeHandle;
import org.chromium.mojo.system.MojoException;
import org.chromium.mojom.firebase.DataSnapshot;
import org.chromium.mojom.firebase.EventType;
import org.chromium.mojom.firebase.Firebase;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class DatabaseReferenceImpl extends Conversions implements org.chromium.mojom.firebase.DatabaseReference {
    private static final String TAG = "DatabaseReferenceImpl";
    private DatabaseReference mReference;

    public DatabaseReferenceImpl(DatabaseReference reference) {
        mReference = reference;
    }

    @Override
    public void close() {}

    @Override
    public void onConnectionError(MojoException e) {}

    @Override
    public void addValueEventListener(String path, org.chromium.mojom.firebase.ValueEventListener listener) {
        final DatabaseReference child = mReference.child(path);
        final org.chromium.mojom.firebase.ValueEventListener.Proxy proxy =
                (org.chromium.mojom.firebase.ValueEventListener.Proxy)listener;
        final ValueEventListener firebaseListener =
                new ValueEventListener() {
                    @Override
                    public void onCancelled(DatabaseError error) {
                        proxy.onCancelled(toMojoError(error));
                    }
                    @Override
                    public void onDataChange(com.google.firebase.database.DataSnapshot snapshot) {
                        proxy.onDataChange(toMojoSnapshot(snapshot));
                    }
                };
        proxy.getProxyHandler().setErrorHandler(new ConnectionErrorHandler() {
            @Override
            public void onConnectionError(MojoException e) {
                child.removeEventListener(firebaseListener);
            }
        });
        child.addValueEventListener(firebaseListener);
    }

     @Override
     public void addChildEventListener(String path, org.chromium.mojom.firebase.ChildEventListener listener) {
         final DatabaseReference child = mReference.child(path);
         final org.chromium.mojom.firebase.ChildEventListener.Proxy proxy =
             (org.chromium.mojom.firebase.ChildEventListener.Proxy)listener;
         final ChildEventListener firebaseListener =
             new ChildEventListener() {
             @Override
             public void onCancelled(DatabaseError error) {
                 proxy.onCancelled(toMojoError(error));
             }
             @Override
             public void onChildAdded(com.google.firebase.database.DataSnapshot snapshot, String previousChildName) {
                 proxy.onChildAdded(toMojoSnapshot(snapshot), previousChildName);
             }
             @Override
             public void onChildChanged(com.google.firebase.database.DataSnapshot snapshot, String previousChildName) {
                 proxy.onChildChanged(toMojoSnapshot(snapshot), previousChildName);
             }
             @Override
             public void onChildMoved(com.google.firebase.database.DataSnapshot snapshot, String previousChildName) {
                 proxy.onChildMoved(toMojoSnapshot(snapshot), previousChildName);
             }
             @Override
             public void onChildRemoved(com.google.firebase.database.DataSnapshot snapshot) {
                 proxy.onChildRemoved(toMojoSnapshot(snapshot));
             }
         };
         proxy.getProxyHandler().setErrorHandler(new ConnectionErrorHandler() {
             @Override
             public void onConnectionError(MojoException e) {
                 child.removeEventListener(firebaseListener);
             }
         });
         child.addChildEventListener(firebaseListener);
     }

     @Override
     public void observeSingleEventOfType(String path, int eventType, final ObserveSingleEventOfTypeResponse response) {
         mReference.child(path).addListenerForSingleValueEvent(new ValueEventListener() {
             @Override
             public void onDataChange(com.google.firebase.database.DataSnapshot snapshot) {
                 response.call(toMojoSnapshot(snapshot));
             }

             @Override
             public void onCancelled(DatabaseError error) {
                 // No-op
             }
         });
     }

    @Override
    public void setValue(String path, String jsonValue, int priority, boolean hasPriority, final SetValueResponse response) {
        try {
          JSONObject root = new JSONObject(jsonValue);
          Object value = toMap(root).get("value");
          mReference.child(path).setValue(value, hasPriority ? priority : null, new CompletionListener() {
              @Override
              public void onComplete(DatabaseError error, DatabaseReference ref) {
                  response.call(toMojoError(error));
              }
          });
        } catch(JSONException e) {
          org.chromium.mojom.firebase.Error mojoError =
            new org.chromium.mojom.firebase.Error();
          mojoError.code = -1;
          mojoError.message = "setValue JSONException";
          Log.e(TAG, "setValue JSONException", e);
          response.call(mojoError);
        }
    }

    @Override
    public void removeValue(String path, final RemoveValueResponse response) {
      mReference.child(path).removeValue(new CompletionListener() {
          @Override
          public void onComplete(DatabaseError error, DatabaseReference ref) {
              response.call(toMojoError(error));
          }
      });
    }

    @Override
    public void push(String path, InterfaceRequest<org.chromium.mojom.firebase.DatabaseReference> request, final PushResponse response) {
        DatabaseReference reference = mReference.child(path).push();
        DatabaseReferenceImpl child = new DatabaseReferenceImpl(reference);
        org.chromium.mojom.firebase.DatabaseReference.MANAGER.bind(child, request);
        response.call(reference.getKey());
    }

    @Override
    public void setPriority(String path, int priority, final SetPriorityResponse response) {
      mReference.child(path).setPriority(priority, new CompletionListener() {
          @Override
          public void onComplete(DatabaseError error, DatabaseReference ref) {
              response.call(toMojoError(error));
          }
      });
    }

    // public domain code from https://gist.github.com/codebutler/2339666
    @SuppressWarnings({ "rawtypes", "unchecked" })
    static Map<String, Object> toMap(JSONObject object) throws JSONException {
        Map<String, Object> map = new HashMap();
        Iterator keys = object.keys();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            map.put(key, fromJson(object.get(key)));
        }
        return map;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    static List toList(JSONArray array) throws JSONException {
        List list = new ArrayList();
        for (int i = 0; i < array.length(); i++) {
            list.add(fromJson(array.get(i)));
        }
        return list;
    }

    static Object fromJson(Object json) throws JSONException {
        if (json == JSONObject.NULL) {
            return null;
        } else if (json instanceof JSONObject) {
            return toMap((JSONObject) json);
        } else if (json instanceof JSONArray) {
            return toList((JSONArray) json);
        } else {
            return json;
        }
    }
}
