import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/utils/border_custom_button.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/custom_button.dart';

class CustomAlertDialogue extends StatelessWidget {
  const CustomAlertDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        children: [
          Image.asset(
            'assets/images/warning.png',
            height: 70,
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            AppStrings.accountDeletion,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Text(
        AppStrings.accountDeletionConfirmation,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
      actions: [
        BorderCustomButton(
            onTap: () {
              Navigator.pop(context);
            },
            text: 'Cancel'),
        const SizedBox(
          height: 10,
        ),
        BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is AccountDeletedState) {
              Navigator.pop(context);
              Navigator.pop(context);
              context.mySnackBar(
                  text: 'Account Deleted Successfully',
                  color: AppColors.darkBlueColor);
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return CustomButton(
                onTap: () {},
                text: '',
                isloading: true,
              );
            }

            return CustomButton(
                onTap: () async {
                  await context.read<AuthCubit>().deleteUserAndFirestoreData();
                },
                text: 'Delete Account');
          },
        ),
      ],
    );
  }
}
