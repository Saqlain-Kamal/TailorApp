import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/home/profile/screens/change_password.dart';
import 'package:tailor_app/app/home/profile/screens/edit_profile.dart';
import 'package:tailor_app/app/home/profile/widgets/custom_alert_dialogue.dart';

import '../../../../utils/constants.dart';
import '../../../auth/viewmodel/cubit/auth_cubit.dart';

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
                  return CustomAlertDialogue(
                    image: 'assets/images/warning.png',
                    title: AppStrings.accountDeletion,
                    desc: AppStrings.accountDeletionConfirmation,
                    btnText1: 'Cancel',
                    btnText2: 'Delete Account',
                    btnOnTap1: (){
                      Navigator.pop(context);
                    },
                    btnOnTap2: () async {
                      await context.read<AuthCubit>().deleteUserAndFirestoreData();
                    },
                  );
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
