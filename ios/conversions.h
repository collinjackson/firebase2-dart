// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "third_party/firebase/mojom/firebase.mojom.h"

@class FIRDataSnapshot;
@class FIRAuthData;
@class NSError;

namespace firebase {

ErrorPtr toMojoError(NSError* error);
DataSnapshotPtr toMojoSnapshot(FIRDataSnapshot* snapshot);
AuthDataPtr toMojoAuthData(FIRAuthData* authData);

}  // namespace firebase
