import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/splash.dart';
import 'package:tailor_app/utils/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkCurrentUser(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is ErrorState) {
              context.mySnackBar(text: state.message, color: Colors.red);
            }
            if (state is PasswordChangedState) {
              context.mySnackBar(
                  text: 'Password Changed Successfully',
                  color: AppColors.darkBlueColor);
            }
            if (state is AuthenticatedState) {
              context.mySnackBar(
                  text: 'Account Created Succesfully',
                  color: AppColors.darkBlueColor);
            }
            if (state is TailorInfoChangedState) {
              context.mySnackBar(
                  text: 'Info Updated Successfully',
                  color: AppColors.darkBlueColor);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            log(state.toString());
            if (state is UnAuthenticatedState) {
              return const AuthPage();
            }
            if (state is AuthenticatedState) {
              log('Home');
              return const Home();
            }
            if (state is ErrorState) {
              return const AuthPage();
            }
            if (state is LoadingState) {
              log('messsssssage');

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greyColor,
                  ),
                ),
              );
            } else {
              log('message');
              return const Splash();
            }
          },
        ),
      ),
    );
  }
}
