import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class GoogleServices {
  signInWithGoogle(BuildContext context, String role) async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication auth = await user!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      log('LoggedIn');
      try {
        final user = UserModel(
          id: value.user!.uid,
          userId: const Uuid().v1(),
          name: value.user?.displayName.toString() ?? 'not found',
          email: value.user!.email.toString(),
          role: role,
        );

        await context.read<AuthCubit>().signupwithGoogle(user: user);
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
