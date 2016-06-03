// Copyright 2016, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

package com.google.firebase.mojo;

import android.content.Context;
import android.util.Log;
import android.content.res.AssetManager;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.crash.FirebaseCrash;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.DatabaseError;

// import com.firebase.client.AuthData;
// import com.firebase.client.FirebaseError;
// import com.firebase.client.Firebase.AuthResultHandler;
// import com.firebase.client.Firebase.CompletionListener;
// import com.firebase.client.Firebase.ResultHandler;
// import com.firebase.client.Firebase.ValueResultHandler;

import com.google.firebase.mojo.Conversions;


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
import org.chromium.mojom.firebase.DatabaseReference;
import org.chromium.mojom.firebase.EventType;
import org.chromium.mojom.firebase.Firebase;
import org.chromium.mojom.firebase.ValueEventListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class FirebaseImpl extends Conversions implements org.chromium.mojom.firebase.Firebase {
    private static final String TAG = "FlutterFirebase";
    static private Context mContext;

    public FirebaseImpl(Context context) {
        mContext = context;
    }

    public static Binding connectToService(Context context, Core core, MessagePipeHandle pipe) {
        return Firebase.MANAGER.bind(new FirebaseImpl(context), pipe);
    }

    @Override
    public void close() {}

    @Override
    public void onConnectionError(MojoException e) {}

    @Override
    public void configure() {
        try {
            FirebaseOptions.Builder builder = new FirebaseOptions.Builder();
            InputStream file = mContext.getAssets().open("google-services.json");
            byte[] contents = new byte[file.available()];
            file.read(contents);
            file.close();
            JSONObject json = new JSONObject(new String(contents));
            JSONObject client = json.getJSONArray("client").getJSONObject(0);

            String databaseUrl = json.getJSONObject("project_info").getString("firebase_url");
            builder.setDatabaseUrl(databaseUrl);

            String apiKey = client.getJSONArray("api_key").getJSONObject(0).getString("current_key");
            builder.setApiKey(apiKey);

            String applicationId = client.getJSONObject("client_info").getString("mobilesdk_app_id");
            builder.setApplicationId(applicationId);
            FirebaseApp.initializeApp(mContext, builder.build());
            Log.v(TAG, "Firebase was configured using google-services.json.");
        } catch(IOException e) {
            Log.e(TAG, "Missing google-services.json. Please add it to the assets folder.", e);
        } catch(JSONException e) {
            Log.e(TAG, "Content of google-services.json was not in the expected format.", e);
        }
    }

    @Override
    public void reference(InterfaceRequest<DatabaseReference> request) {
        DatabaseReferenceImpl impl = new DatabaseReferenceImpl(FirebaseDatabase.getInstance().getReference());
        DatabaseReferenceImpl.MANAGER.bind(impl, request);
    }

    @Override
    public void signInAnonymously(final SignInAnonymouslyResponse response) {
        FirebaseAuth.getInstance().signInAnonymously().addOnCompleteListener(new OnCompleteListener<AuthResult>() {
            @Override
            public void onComplete(Task<AuthResult> task) {
                if (task.isSuccessful())
                    response.call(toMojoUser(task.getResult().getUser()), null);
                else
                    response.call(null, toMojoException(task.getException()));
            }
        });
    }

    @Override
    public void signOut(final SignOutResponse response) {
        FirebaseAuth.getInstance().signOut();
        response.call(null);
    }

    @Override
    public void logCrash(String message) {
        // TODO(jackson): This isn't functional until the crash service is started properly
        Log.v(TAG, "Firebase crash reporting isn't functional on Android yet. Message:" + message);
        FirebaseCrash.log(message);
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
