import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/screens/continue_profile.dart';
import 'package:tailor_app/app/auth/screens/create_account.dart';
import 'package:tailor_app/app/auth/screens/location_access.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:tailor_app/app/cubit/location_cubit/location_cubit.dart';
import 'package:tailor_app/app/cubit/measurment_cubit/measurment_cubit.dart';
import 'package:tailor_app/app/cubit/profile_cubit/profile_cubit.dart';
import 'package:tailor_app/app/cubit/review_cubit/review_cubit.dart';
import 'package:tailor_app/app/cubit/send_request_cubit/send_request_cubit.dart';
import 'package:tailor_app/app/cubit/tailor_cubits/cubits/tailor_cubit.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/home/home.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/splash.dart';

import 'app/customer/customer_home/customer_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..checkCurrentUser(context),
        ),
        BlocProvider(
          create: (context) => TailorCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => ReviewCubit(),
        ),
        BlocProvider(
          create: (context) => MeasurmentCubit(),
        ),
        BlocProvider(
          create: (context) => SendRequestCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Sen',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocConsumer<AuthCubit, AuthStates>(
          buildWhen: (previousState, currentState) {
            log(previousState.toString(), name: 'Here is my previous state');
            log(currentState.toString(), name: 'Here is my current state');
            if (previousState is AuthenticatedState &&
                currentState is AuthenticatedState) {
              return previousState.user != currentState.user;
            }
            return true;
          },
          listener: (context, state) {
            if (state is ErrorState) {
              log('I am There');
              log(state.message.toString());
              context.mySnackBar(text: state.message, color: Colors.red);
            }
            if (state is PasswordChangedState) {
              context.mySnackBar(
                  text: 'Password Changed Successfully',
                  color: AppColors.darkBlueColor);
            }
            if (state is AuthenticatedState) {
              state.message != null
                  ? context.mySnackBar(
                      text: state.message!, color: AppColors.darkBlueColor)
                  : const SizedBox();
            }

            // if (state is AccountCreateScreenState) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const CreateAccount()),
            //   );
            // }
            // if (state is ContinueProfileScreenState) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ContinueProfile(
            //               user: state.user,
            //               password: state.password,
            //             )),
            //   );
            // }
            // if (state is LocationAccessScreenState) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => LocationAccessScreen(
            //               user: state.user,
            //               password: state.password,
            //             )),
            //   );
            // }

            // if (state is TailorInfoChangedState) {
            //   log('ji');
            //   context.mySnackBar(
            //       text: 'Info Updated Successfully',
            //       color: AppColors.darkBlueColor);
            // }
            // TODO: implement listener
          },
          builder: (context, state) {
            log(state.toString());
            if (state is UnAuthenticatedState) {
              log('HIiiiii');
              return const AuthPage();
            }

            if (state is AuthenticatedState) {
              log('Home');
              final role = context.read<AuthCubit>().appUser!.role;
              return role == 'Tailor'
                  ? const Home(
                      index: 0,
                    )
                  : const CustomerHome();
            }
            if (state is LoadedState) {
              log('Home');
              final role = context.read<AuthCubit>().appUser!.role;
              return role == 'Tailor'
                  ? const Home(
                      index: 0,
                    )
                  : const CustomerHome();
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
