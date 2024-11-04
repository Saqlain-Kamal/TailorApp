import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';

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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ManageAccount(),
              //   ),
              // );
            },
            readOnly: true,
            hint: 'Edit Profile',
            prefixIcon: 'assets/images/user-edit.png',
          ),
          CustomeTextField(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ManageAccount(),
              //   ),
              // );
            },
            readOnly: true,
            hint: 'Change Password',
            prefixIcon: 'assets/images/user-edit.png',
          ),
          CustomeTextField(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const ManageAccount(),
              //   ),
              // );
            },
            readOnly: true,
            hint: 'Delete Account',
            prefixIcon: 'assets/images/user-edit.png',
          ),
        ],
      ),
    );
  }
}
