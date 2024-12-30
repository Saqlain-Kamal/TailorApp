import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/customer/customer_home/customer_dashboard/screens/customer_dashboard.dart';
import 'package:tailor_app/app/customer/customer_home/customer_favorite/screens/customer_favorite.dart';
import 'package:tailor_app/app/home/chat/screens/chat.dart';
import 'package:tailor_app/app/home/orders/screens/orders.dart';
import 'package:tailor_app/app/home/profile/screens/profile.dart';

import '../../../utils/colors.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const CustomerDashboard(),
      const CustomerFavorite(),
      const Chat(),
      const Profile(),
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey.shade100,
          fixedColor: AppColors.darkBlueColor,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: currentIndex == 0
                    ? const Image(
                        height: 25,
                        image: AssetImage(
                          'assets/images/gradientHome.png',
                        ),
                      )
                    : const Image(
                        height: 22,
                        image: AssetImage(
                          'assets/images/home.png',
                        ),
                      ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? const Image(
                      height: 25,
                      image: AssetImage(
                        'assets/images/gradientOrder.png',
                      ),
                    )
                  : const Image(
                      height: 22,
                      image: AssetImage(
                        'assets/images/order.png',
                      ),
                    ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
                icon: currentIndex == 2
                    ? const Image(
                        height: 25,
                        image: AssetImage(
                          'assets/images/gradientChat.png',
                        ),
                      )
                    : const Image(
                        height: 22,
                        image: AssetImage(
                          'assets/images/chat.png',
                        ),
                      ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: currentIndex == 3
                    ? const Image(
                  height: 25,
                  image: AssetImage(
                    'assets/images/gradientProfile.png',
                  ),
                )
                    : const Image(
                  height: 22,
                  image: AssetImage(
                    'assets/images/profile.png',
                  ),
                ),
                label: 'Profile'),

          ],
        ),
      ),
    );
  }
}
