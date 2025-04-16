import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/screens/auth_page.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/model/user_model.dart';
import 'package:tailor_app/app/utils/colors.dart';

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
            user.shopName!,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
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
                await context.read<AuthController>().signOut().then(
                      (onValue) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthPage()),
                        (Route<dynamic> route) =>
                            false, // Removes all previous routes
                      ),
                    );

                log('I am here');
              } catch (e) {
                log(e.toString());
              }
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset(
                'assets/images/notification.png',
                height: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
