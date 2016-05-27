// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "conversions.h"
#include "database_reference_impl.h"
#include "firebase_impl.h"

#import <FirebaseAnalytics/FIRApp.h>
#import <FirebaseAnalytics/FIROptions.h>
#import <FirebaseAuth/FIRAuth.h>
#import <FirebaseDatabase/FIRDatabase.h>
#import <FirebaseCrash/FirebaseCrash.h>

namespace firebase {


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
*/
void FirebaseImpl::SignInAnonymously(
  const SignInAnonymouslyCallback& callback) {
  SignInAnonymouslyCallback *copyCallback =
    new SignInAnonymouslyCallback(callback);
  [[FIRAuth auth] signInAnonymouslyWithCompletion:^(FIRUser *user, NSError *error) {
    copyCallback->Run(toMojoUser(user), toMojoError(error));
    delete copyCallback;
  }];
}
/*
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
*/
void FirebaseImpl::SignOut(const SignOutCallback& callback) {
  NSError *error = nil;
  [[FIRAuth auth] signOut:&error];
  callback.Run(toMojoError(error));
}
/*
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

void FirebaseImpl::LogCrash(const mojo::String& message) {
  FIRCrashLog(@"%s", message.data());
}

}  // namespace firebase

void FlutterServicePerform(mojo::ScopedMessagePipeHandle client_handle,
                           const mojo::String& service_name) {
  if (service_name == firebase::Firebase::Name_) {
    new firebase::FirebaseImpl(
        mojo::MakeRequest<firebase::Firebase>(client_handle.Pass()));
    return;
  }
}
