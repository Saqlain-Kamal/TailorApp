import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // loadData();
  }

  void loadData() {
    Future.delayed(const Duration(seconds: 3), () {
      context.read<AuthCubit>().checkCurrentUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
    );
  }
}
