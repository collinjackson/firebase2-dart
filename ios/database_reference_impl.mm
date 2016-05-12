// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "conversions.h"
#include "database_reference_impl.h"
#include "firebase_impl.h"

#import <FirebaseAnalytics/FIRApp.h>
#import <FirebaseAnalytics/FIROptions.h>
#import <FirebaseDatabase/FIRDatabaseReference.h>
#import <FirebaseDatabase/FIRDataEventType.h>

namespace firebase {

DatabaseReferenceImpl::DatabaseReferenceImpl(
  mojo::InterfaceRequest<::firebase::DatabaseReference> request,
  FIRDatabaseReference *reference)
    : binding_(this, request.Pass()), reference_([reference retain]) {}

DatabaseReferenceImpl::~DatabaseReferenceImpl() {
  [reference_ release];
}

void DatabaseReferenceImpl::AddValueEventListener(
  const mojo::String& path,
  mojo::InterfaceHandle<ValueEventListener> info) {
  ValueEventListenerPtr ptr = ValueEventListenerPtr::Create(info.Pass());
  ::firebase::ValueEventListener *listener = ptr.get();
  FIRDatabaseReference *child = childForPath(path);
  FIRDatabaseHandle handle = [child observeEventType:FIRDataEventTypeValue
                                           withBlock:^(FIRDataSnapshot *snapshot) {
    listener->OnDataChange(toMojoSnapshot(snapshot));
  } withCancelBlock:^(NSError *error) {
    listener->OnCancelled(toMojoError(error));
  }];
  ptr.set_connection_error_handler([this, child, handle, listener]() {
    [child removeObserverWithHandle:handle];
    auto it = std::find_if(value_event_listeners_.begin(),
                           value_event_listeners_.end(),
                           [listener](const ::firebase::ValueEventListenerPtr& p) {
                             return (p.get() == listener);
                           });
    value_event_listeners_.erase(it);
  });
  value_event_listeners_.emplace_back(ptr.Pass());
}

void DatabaseReferenceImpl::AddChildEventListener(
  const mojo::String& path,
  mojo::InterfaceHandle<ChildEventListener> info) {
  ChildEventListenerPtr ptr = ChildEventListenerPtr::Create(info.Pass());
  ::firebase::ChildEventListener *listener = ptr.get();
  FIRDatabaseReference *child = childForPath(path);
  void (^cancelBlock)(NSError *) = ^(NSError *error) {
    listener->OnCancelled(toMojoError(error));
  };
  void (^addedBlock)(FIRDataSnapshot *, NSString *) = ^(FIRDataSnapshot *snapshot, NSString *prevKey) {
    listener->OnChildAdded(toMojoSnapshot(snapshot), prevKey.UTF8String);
  };
  FIRDatabaseHandle addedHandle = [child observeEventType:FIRDataEventTypeChildAdded
                           andPreviousSiblingKeyWithBlock:addedBlock
                                          withCancelBlock:cancelBlock];
  void (^changedBlock)(FIRDataSnapshot *, NSString *) = ^(FIRDataSnapshot *snapshot, NSString *prevKey) {
    listener->OnChildChanged(toMojoSnapshot(snapshot), prevKey.UTF8String);
  };
  FIRDatabaseHandle changedHandle = [child observeEventType:FIRDataEventTypeChildChanged
                             andPreviousSiblingKeyWithBlock:changedBlock
                                            withCancelBlock:cancelBlock];
  void (^movedBlock)(FIRDataSnapshot *, NSString *) = ^(FIRDataSnapshot *snapshot, NSString *prevKey) {
    listener->OnChildMoved(toMojoSnapshot(snapshot), prevKey.UTF8String);
  };
  FIRDatabaseHandle movedHandle = [child observeEventType:FIRDataEventTypeChildMoved
                           andPreviousSiblingKeyWithBlock:movedBlock
                                          withCancelBlock:cancelBlock];
  void (^removedBlock)(FIRDataSnapshot *snapshot) = ^(FIRDataSnapshot *snapshot) {
    listener->OnChildRemoved(toMojoSnapshot(snapshot));
  };
  FIRDatabaseHandle removedHandle = [child observeEventType:FIRDataEventTypeChildRemoved
                                                  withBlock:removedBlock
                                            withCancelBlock:cancelBlock];
  ptr.set_connection_error_handler(
    [this, child, addedHandle, changedHandle, movedHandle, removedHandle, listener]() {
      [child removeObserverWithHandle:addedHandle];
      [child removeObserverWithHandle:changedHandle];
      [child removeObserverWithHandle:movedHandle];
      [child removeObserverWithHandle:removedHandle];
      auto it = std::find_if(child_event_listeners_.begin(),
                             child_event_listeners_.end(),
                             [listener](const ::firebase::ChildEventListenerPtr& p) {
                               return (p.get() == listener);
                             });
      child_event_listeners_.erase(it);
    }
  );
  child_event_listeners_.emplace_back(ptr.Pass());
}

void DatabaseReferenceImpl::ObserveSingleEventOfType(
    const mojo::String& path,
    ::firebase::EventType eventType,
    const ObserveSingleEventOfTypeCallback& callback) {
  ObserveSingleEventOfTypeCallback *copyCallback =
    new ObserveSingleEventOfTypeCallback(callback);
  [childForPath(path) observeSingleEventOfType:static_cast<FIRDataEventType>(eventType)
                          withBlock:^(FIRDataSnapshot *snapshot) {
    copyCallback->Run(toMojoSnapshot(snapshot));
    delete copyCallback;
  }];
}

void DatabaseReferenceImpl::SetValue(
    const mojo::String& path,
    const mojo::String& jsonValue,
    int32_t priority,
    bool hasPriority,
    const SetValueCallback& callback) {
  SetValueCallback *copyCallback =
    new SetValueCallback(callback);
  NSData *data = [@(jsonValue.data()) dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  NSDictionary *valueDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0
                                                                    error:&error];
  id value = [valueDictionary valueForKey:@"value"];
  void (^completionBlock)(NSError *, ::FIRDatabaseReference* ref) = ^(NSError* error, ::FIRDatabaseReference* ref) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  };
  FIRDatabaseReference *child = childForPath(path);
  if (valueDictionary != nil) {
    if (hasPriority) {
      [child       setValue:value
                andPriority:@(priority)
        withCompletionBlock:completionBlock];
    } else {
      [child setValue:value withCompletionBlock:completionBlock];
    }
  } else {
    completionBlock(error, child);
  }
}

void DatabaseReferenceImpl::RemoveValue(
    const mojo::String& path,
    const RemoveValueCallback& callback) {
  RemoveValueCallback *copyCallback =
    new RemoveValueCallback(callback);
  [reference_ removeValueWithCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}

void DatabaseReferenceImpl::Push(
    const mojo::String& path,
    mojo::InterfaceRequest<DatabaseReference> request,
    const PushCallback& callback) {
  FIRDatabaseReference *child = [[childForPath(path) childByAutoId] retain];
  new DatabaseReferenceImpl(request.Pass(), child);
  callback.Run(child.key.UTF8String);
}

void DatabaseReferenceImpl::SetPriority(
  const mojo::String& path,
  int32_t priority,
  const SetPriorityCallback& callback) {
  SetPriorityCallback *copyCallback =
    new SetPriorityCallback(callback);
  [childForPath(path) setPriority:@(priority)
              withCompletionBlock:^(NSError *error, FIRDatabaseReference *ref) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}

FIRDatabaseReference *DatabaseReferenceImpl::childForPath(const mojo::String& path) {
  if (path.size() > 0)
    return [reference_ child:@(path.data())];
  return reference_;
}

}  // namespace firebase
