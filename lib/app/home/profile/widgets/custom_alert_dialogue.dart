import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/viewmodel/states/auth_states.dart';
import 'package:tailor_app/app/extension/snackbar.dart';
import 'package:tailor_app/app/utils/border_custom_button.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/custom_button.dart';

class CustomAlertDialogue extends StatelessWidget {
  const CustomAlertDialogue({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    this.showBtn1 = true,
    this.btnText1 = "",
    required this.btnText2,
    this.btnOnTap1,
    required this.btnOnTap2,
  });
  final String image;
  final String title;
  final String desc;
  final bool showBtn1;
  final String btnText1;
  final String btnText2;
  final void Function()? btnOnTap1;
  final void Function()? btnOnTap2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Column(
        children: [
          Image.asset(
            image,
            height: 70,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        desc,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
      actions: [
        if (showBtn1) BorderCustomButton(onTap: btnOnTap1, text: btnText1),
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

            return CustomButton(onTap: btnOnTap2, text: btnText2);
          },
        ),
      ],
    );
  }
}
