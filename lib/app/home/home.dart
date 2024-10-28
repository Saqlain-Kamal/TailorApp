import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/chat/screens/chat.dart';
import 'package:tailor_app/app/home/dashboard/screens/dashboard.dart';
import 'package:tailor_app/app/home/orders/screens/orders.dart';
import 'package:tailor_app/app/home/profile/screens/profile.dart';
import 'package:tailor_app/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    const Dashboard(),
    const Orders(),
    const Chat(),
    const Profile(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BottomNavigationBar(
          backgroundColor: AppColors.borderGreyColor,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Orders',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          ],
        ),
      ),
    );
  }
}
