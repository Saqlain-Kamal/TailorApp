import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';

class DashboardTop extends StatelessWidget {
  const DashboardTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
          title: const Text(
            AppStrings.userName,
            style: TextStyle(color: Colors.white),
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
          trailing: Image.asset('assets/images/notification.png'),
        ),
      ),
    );
  }
}
