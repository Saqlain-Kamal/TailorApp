import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_dashboard.dart';
import 'package:tailor_app/app/customer/customer_home/customer_home.dart';
import 'package:tailor_app/app/home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    Future.delayed(const Duration(seconds: 2), () async {
      final currentUser =
          await context.read<AuthController>().checkCurrentUser(context);

      if (currentUser != null) {
        // ignore: use_build_context_synchronously

        if (context.read<AuthController>().appUser!.role == 'Tailor') {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Home(
                index: 0,
              ),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomerHome(),
            ),
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthPage(),
          ),
        );
      }
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
