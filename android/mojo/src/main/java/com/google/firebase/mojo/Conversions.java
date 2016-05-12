package com.google.firebase.mojo;

import com.google.firebase.database.DatabaseError;


import java.io.InputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;
import java.util.Map;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;



public class Conversions {
    org.chromium.mojom.firebase.DataSnapshot toMojoSnapshot(com.google.firebase.database.DataSnapshot snapshot) {
        org.chromium.mojom.firebase.DataSnapshot mojoSnapshot = new org.chromium.mojom.firebase.DataSnapshot();
        mojoSnapshot.key = snapshot.getKey();
        Map<String, Object> jsonValue = new HashMap<String, Object>();
        jsonValue.put("value", snapshot.getValue());
        mojoSnapshot.jsonValue = new JSONObject(jsonValue).toString();
        return mojoSnapshot;
    }

    org.chromium.mojom.firebase.Error toMojoError(DatabaseError error) {
        if (error == null)
            return null;
        org.chromium.mojom.firebase.Error mojoError =
                new org.chromium.mojom.firebase.Error();
        mojoError.code = error.getCode();
        mojoError.message = error.getMessage();
        return mojoError;
    }

    org.chromium.mojom.firebase.Error toMojoException(Throwable exception) {
        if (exception == null)
            return null;
        org.chromium.mojom.firebase.Error mojoException =
                new org.chromium.mojom.firebase.Error();
        mojoException.message = exception.getMessage();
        return mojoException;
    }

    org.chromium.mojom.firebase.User toMojoUser(com.google.firebase.auth.FirebaseUser user) {
        org.chromium.mojom.firebase.User mojoUser =
                new org.chromium.mojom.firebase.User();
        mojoUser.uid = user.getUid();
        mojoUser.providerId = user.getProviderId();
        return mojoUser;
    }
}
