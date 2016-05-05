// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "conversions.h"

#import <FIRDatabaseReference.h>

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

// AuthDataPtr toMojoAuthData(FIRAuthData* authData) {
//   AuthDataPtr mojoAuthData(::firebase::AuthData::New());
//   mojoAuthData->uid = authData.uid.UTF8String;
//   mojoAuthData->provider = authData.provider.UTF8String;
//   // mojoAuthData->token = base::SysNSStringToUTF8(authData.token);
//   return mojoAuthData.Pass();
// }

}  // namespace firebase
