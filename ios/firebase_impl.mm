// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "database_reference_impl.h"
#include "firebase_impl.h"
#include "base/logging.h"
#include "base/strings/sys_string_conversions.h"

#import <FIRApp.h>
#import <FIROptions.h>
#import <FIRDatabase.h>

namespace firebase {
/*
::firebase::DataSnapshotPtr toMojoSnapshot(FDataSnapshot* snapshot) {
  ::firebase::DataSnapshotPtr mojoSnapshot(::firebase::DataSnapshot::New());
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

::firebase::ErrorPtr toMojoError(NSError* error) {
  ::firebase::ErrorPtr mojoError(::firebase::Error::New());
  mojoError->code = error.code;
  mojoError->message = error.description.UTF8String;
  return mojoError.Pass();
}

::firebase::AuthDataPtr toMojoAuthData(FAuthData* authData) {
  ::firebase::AuthDataPtr mojoAuthData(::firebase::AuthData::New());
  mojoAuthData->uid = authData.uid.UTF8String;
  mojoAuthData->provider = authData.provider.UTF8String;
  // mojoAuthData->token = base::SysNSStringToUTF8(authData.token);
  return mojoAuthData.Pass();
}
*/
FirebaseImpl::FirebaseImpl(mojo::InterfaceRequest<::firebase::Firebase> request)
    : binding_(this, request.Pass()) {}

FirebaseImpl::~FirebaseImpl() {
}

void FirebaseImpl::Configure() {
  [FIRApp configure];
}

void FirebaseImpl::Reference(mojo::InterfaceRequest<DatabaseReference> request) {
  new DatabaseReferenceImpl(request.Pass(), [FIRDatabase database].reference);
}

/*
void FirebaseImpl::AuthWithCustomToken(
  const mojo::String& token,
  const AuthWithCustomTokenCallback& callback) {
}

void FirebaseImpl::AuthAnonymously(
  const AuthAnonymouslyCallback& callback) {
  AuthAnonymouslyCallback *copyCallback =
    new AuthAnonymouslyCallback(callback);
  [client_ authAnonymouslyWithCompletionBlock:^(NSError *error, FAuthData *authData) {
    copyCallback->Run(toMojoError(error), toMojoAuthData(authData));
    delete copyCallback;
  }];
}

void FirebaseImpl::AuthWithOAuthToken(
  const mojo::String& provider,
  const mojo::String& credentials,
  const AuthWithOAuthTokenCallback& callback) {
  AuthWithOAuthTokenCallback *copyCallback =
    new AuthWithOAuthTokenCallback(callback);
  [client_ authWithOAuthProvider:@(provider.data())
                           token:@(credentials.data())
             withCompletionBlock:^(NSError *error, FAuthData *authData) {
    copyCallback->Run(toMojoError(error), toMojoAuthData(authData));
    delete copyCallback;
  }];
}

void FirebaseImpl::AuthWithPassword(
  const mojo::String& email,
  const mojo::String& password,
  const AuthWithPasswordCallback& callback) {
  AuthWithPasswordCallback *copyCallback =
    new AuthWithPasswordCallback(callback);
  [client_      authUser:@(email.data())
                password:@(password.data())
     withCompletionBlock:^(NSError *error, FAuthData *authData) {
    copyCallback->Run(toMojoError(error), toMojoAuthData(authData));
    delete copyCallback;
  }];
}

void FirebaseImpl::Unauth(const UnauthCallback& callback) {
  [client_ unauth];
  callback.Run(toMojoError(nullptr));
}

void FirebaseImpl::CreateUser(const mojo::String& email,
  const mojo::String& password,
  const CreateUserCallback& callback) {
  CreateUserCallback *copyCallback =
    new CreateUserCallback(callback);
  [client_   createUser:@(email.data())
               password:@(password.data())
    withValueCompletionBlock:^(NSError *error, NSDictionary *valueDictionary) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:valueDictionary
                                                   options:0
                                                     error:nil];
    if (data != nil) {
      NSString *jsonValue = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
      copyCallback->Run(toMojoError(error), base::SysNSStringToUTF8(jsonValue));
    } else {
      copyCallback->Run(toMojoError(error), nullptr);
    }
    delete copyCallback;
  }];
}

void FirebaseImpl::ChangeEmail(const mojo::String& oldEmail,
  const mojo::String& password,
  const mojo::String& newEmail,
  const ChangeEmailCallback& callback) {
  ChangeEmailCallback *copyCallback =
    new ChangeEmailCallback(callback);
  [client_ changeEmailForUser:@(oldEmail.data())
                     password:@(password.data())
                   toNewEmail:@(newEmail.data())
          withCompletionBlock:^(NSError *error) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}

void FirebaseImpl::ChangePassword(
  const mojo::String& newPassword,
  const mojo::String& email,
  const mojo::String& oldPassword,
  const ChangePasswordCallback& callback) {
  ChangePasswordCallback *copyCallback =
    new ChangePasswordCallback(callback);
  [client_ changePasswordForUser:@(email.data())
                         fromOld:@(oldPassword.data())
                           toNew:@(newPassword.data())
             withCompletionBlock:^(NSError *error) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}

void FirebaseImpl::RemoveUser(const mojo::String& email,
  const mojo::String& password,
  const RemoveUserCallback& callback) {
  RemoveUserCallback *copyCallback =
    new RemoveUserCallback(callback);
  [client_  removeUser:@(email.data())
               password:@(password.data())
    withCompletionBlock:^(NSError *error) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}

void FirebaseImpl::ResetPassword(const mojo::String& email,
  const ResetPasswordCallback& callback) {
  ResetPasswordCallback *copyCallback =
    new ResetPasswordCallback(callback);
  [client_  resetPasswordForUser:@(email.data())
             withCompletionBlock:^(NSError *error) {
    copyCallback->Run(toMojoError(error));
    delete copyCallback;
  }];
}
*/

// class StrongBindingFirebaseImpl : public FirebaseImpl {
//  public:
//   explicit StrongBindingFirebaseImpl(mojo::InterfaceRequest<Firebase> handle)
//       : strong_binding_(this, handle.Pass()) {}
//
//  private:
//   mojo::StrongBinding<Firebase> strong_binding_;
// };

}  // namespace firebase

void FlutterServicePerform(mojo::ScopedMessagePipeHandle client_handle,
                           const mojo::String& service_name) {
  if (service_name == firebase::Firebase::Name_) {
    new firebase::FirebaseImpl(
        mojo::MakeRequest<firebase::Firebase>(client_handle.Pass()));
    return;
  }
}
