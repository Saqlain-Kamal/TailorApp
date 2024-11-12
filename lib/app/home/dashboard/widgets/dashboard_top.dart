import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/model/user_model.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/utils/colors.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({
    required this.user,
    super.key,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        color: AppColors.darkBlueColor,
      ),
      child: Center(
        child: ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar2.png'),
            radius: 40,
          ),
          title: Text(
            user.name!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Row(
            children: [
              const Text(
                '20 orders.',
                style: TextStyle(color: Colors.white),
              ),
              Image.asset('assets/images/star.png'),
              const Text(
                '4.8',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          trailing: GestureDetector(
            onTap: () async {
              try {
                await context.read<AuthCubit>().signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                  (Route<dynamic> route) =>
                      false, // Removes all previous routes
                );
              } catch (e) {
                log(e.toString());
              }
            },
            child: Image.asset(
              'assets/images/notification.png',
              height: 30,
            ),
          ),
        ),
      ),
    );
  }
}
