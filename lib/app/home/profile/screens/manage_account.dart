import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/home/profile/screens/change_password.dart';
import 'package:tailor_app/app/home/profile/screens/edit_profile.dart';
import 'package:tailor_app/app/home/profile/widgets/custom_alert_dialogue.dart';

class ManageAccount extends StatelessWidget {
  const ManageAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Account'),
      ),
      body: Column(
        children: [
          CustomeTextField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfile(),
                ),
              );
            },
            readOnly: true,
            hint: 'Edit Profile',
            prefixIcon: 'assets/images/user-edit.png',
          ),
          CustomeTextField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePassword(),
                ),
              );
            },
            readOnly: true,
            hint: 'Change Password',
            prefixIcon: 'assets/images/repeate-music.png',
          ),
          CustomeTextField(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const CustomAlertDialogue();
                },
              );
            },
            readOnly: true,
            hint: 'Delete Account',
            prefixIcon: 'assets/images/trash.png',
          ),
        ],
      ),
    );
  }
}
