// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "conversions.h"

#import <FirebaseAuth/FIRUser.h>
#import <FirebaseDatabase/FIRDatabaseReference.h>

namespace firebase {

DataSnapshotPtr toMojoSnapshot(FIRDataSnapshot* snapshot) {
  DataSnapshotPtr mojoSnapshot(::firebase::DataSnapshot::New());
  mojoSnapshot->key = snapshot.key.UTF8String;
  NSDictionary *valueDictionary = @{@"value": snapshot.value};
  NSData *data = [NSJSONSerialization dataWithJSONObject:valueDictionary
                                                 options:0
                                                   error:nil];
  if (data != nil) {
    NSString *jsonValue = [[NSString alloc] initWithData:data
                                                encoding:NSUTF8StringEncoding];
    mojoSnapshot->jsonValue = jsonValue.UTF8String;
  }
  return mojoSnapshot.Pass();
}

ErrorPtr toMojoError(NSError* error) {
  ErrorPtr mojoError(::firebase::Error::New());
  mojoError->code = error.code;
  mojoError->message = error.description.UTF8String;
  return mojoError.Pass();
}

UserPtr toMojoUser(FIRUser* user) {
  UserPtr mojoUser(::firebase::User::New());
  mojoUser->providerID = user.providerID.UTF8String;
  mojoUser->uid = user.uid.UTF8String;
  mojoUser->displayName = user.displayName.UTF8String;
  mojoUser->photoURL = user.photoURL.absoluteString.UTF8String;
  mojoUser->email = user.email.UTF8String;
  return mojoUser.Pass();
}

}  // namespace firebase
