// Copyright 2016 Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef IOS_FIREBASEIMPL_H_
#define IOS_FIREBASEIMPL_H_

#include "base/macros.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "third_party/firebase/mojom/firebase.mojom.h"

#if __OBJC__
@class Firebase;
#else   // __OBJC__
class Firebase;
#endif  // __OBJC__

namespace firebase {

class FirebaseImpl : public ::firebase::Firebase {
 public:
  explicit FirebaseImpl(mojo::InterfaceRequest<Firebase> request);
  ~FirebaseImpl() override;

  void Configure() override;
  void Reference(mojo::InterfaceRequest<DatabaseReference> request) override;
  void SignInAnonymously(
    const SignInAnonymouslyCallback& callback) override;
  void SignOut(const SignOutCallback& callback) override;
  // void AuthWithCustomToken(
  //   const mojo::String& token,
  //   const AuthWithCustomTokenCallback& callback) override;
  // void AuthWithOAuthToken(
  //   const mojo::String& provider,
  //   const mojo::String& credentials,
  //   const AuthWithOAuthTokenCallback& callback) override;
  // void AuthWithPassword(
  //   const mojo::String& email,
  //   const mojo::String& password,
  //   const AuthWithPasswordCallback& callback) override;
  // void CreateUser(const mojo::String& email,
  //   const mojo::String& password,
  //   const CreateUserCallback& callback) override;
  // void ChangeEmail(const mojo::String& oldEmail,
  //   const mojo::String& password,
  //   const mojo::String& newEmail,
  //   const ChangeEmailCallback& callback) override;
  // void ChangePassword(
  //   const mojo::String& newPassword,
  //   const mojo::String& email,
  //   const mojo::String& oldPassword,
  //   const ChangePasswordCallback& callback) override;
  // void RemoveUser(const mojo::String& email,
  //   const mojo::String& password,
  //   const RemoveUserCallback& callback) override;
  // void ResetPassword(const mojo::String& email,
  //   const ResetPasswordCallback& callback) override;
  void LogCrash(const mojo::String& message) override;
 private:
  mojo::StrongBinding<::firebase::Firebase> binding_;
  std::vector<::firebase::ValueEventListenerPtr> value_event_listeners_;
  std::vector<::firebase::ChildEventListenerPtr> child_event_listeners_;

  DISALLOW_COPY_AND_ASSIGN(FirebaseImpl);
};

}  // namespace firebase

#endif  // IOS_FIREBASEIMPL_H_
