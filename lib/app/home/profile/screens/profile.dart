import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tailor_app/app/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/auth/widgets/drop_down_type.dart';
import 'package:tailor_app/app/home/profile/screens/manage_account.dart';
import 'package:tailor_app/utils/constants.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> languageItems = [
    'English',
    'Urdu',
  ];
  final List<String> notificationItems = [
    'Order Notification',
    'Chat Notification',
  ];
  String? languageSelectedValue;
  String? notificationSelectedValue;
  final manageAccountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().appUser;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/avatar2.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(user!.name!),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: screenHeight(context) * 0.37,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      AppStrings.manageAccount,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomeTextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageAccount(),
                        ),
                      );
                    },
                    readOnly: true,
                    hint: 'Manage Account',
                    prefixIcon: 'assets/images/user2.png',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      AppStrings.selectLanguage,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropDownType(
                    isNotification: false,
                    hintText: 'Select Language',
                    selectedValue: languageSelectedValue,
                    items: languageItems,
                    onChanged: (p0) {
                      setState(() {
                        languageSelectedValue = p0;
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      AppStrings.notificationSetting,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropDownType(
                    isNotification: true,
                    prefixImage: 'assets/images/notificationBorder.png',
                    hintText: 'Notification Setting',
                    selectedValue: notificationSelectedValue,
                    items: notificationItems,
                    onChanged: (p0) {
                      setState(() {
                        notificationSelectedValue = p0;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
