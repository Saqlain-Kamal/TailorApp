import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';

class GoogleServices {
  signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication auth = await user!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      log('LoggedIn');
      try {
        final user = UserModel(
          id: value.user!.uid,
          name: value.user?.displayName.toString() ?? 'not found',
          email: value.user!.email.toString(),
        );

        context.read<AuthCubit>().signupwithGoogle(user: user);
      } catch (e) {}
    });
  }
}
