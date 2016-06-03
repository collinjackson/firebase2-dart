// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SKY_SERVICES_FIREBASE_IOS_FIREBASEIMPL_H_
#define SKY_SERVICES_FIREBASE_IOS_FIREBASEIMPL_H_

#include "base/macros.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "third_party/firebase/mojom/firebase.mojom.h"

#if __OBJC__
@class FIRDatabaseReference;
#else   // __OBJC__
class FIRDatabaseReference;
#endif  // __OBJC__

namespace firebase {

class DatabaseReferenceImpl : public ::firebase::DatabaseReference {
 public:
  explicit DatabaseReferenceImpl(
    mojo::InterfaceRequest<DatabaseReference> request,
    FIRDatabaseReference *reference);
  ~DatabaseReferenceImpl() override;

  void AddValueEventListener(
    const mojo::String& path,
    mojo::InterfaceHandle<ValueEventListener> info) override;
  void AddChildEventListener(
    const mojo::String& path,
    mojo::InterfaceHandle<ChildEventListener> info) override;
  void ObserveSingleEventOfType(
    const mojo::String& path,
    ::firebase::EventType eventType,
    const ObserveSingleEventOfTypeCallback& callback) override;
  void RemoveValue(
    const mojo::String& path,
    const RemoveValueCallback& callback) override;
  void SetValue(
    const mojo::String& path,
    const mojo::String& jsonValue,
    int32_t priority,
    bool hasPriority,
    const SetValueCallback& callback) override;
  void Push(
    const mojo::String& path,
    mojo::InterfaceRequest<DatabaseReference> child,
    const PushCallback& callback) override;
   void SetPriority(
     const mojo::String& path,
     int32_t priority,
     const SetPriorityCallback& callback) override;
 private:
  // convenience method for turning path argument into an FIRDatabaseReference
  FIRDatabaseReference *childForPath(const mojo::String& path);

  mojo::StrongBinding<::firebase::DatabaseReference> binding_;
  FIRDatabaseReference *reference_;
  std::vector<::firebase::ValueEventListenerPtr> value_event_listeners_;
  std::vector<::firebase::ChildEventListenerPtr> child_event_listeners_;

  DISALLOW_COPY_AND_ASSIGN(DatabaseReferenceImpl);
};

}  // namespace firebase

#endif  // SKY_SERVICES_FIREBASE_IOS_FIREBASEIMPL_H_
