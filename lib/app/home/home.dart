import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/chat/screens/chat.dart';
import 'package:tailor_app/app/home/dashboard/screens/dashboard.dart';
import 'package:tailor_app/app/home/orders/screens/orders.dart';
import 'package:tailor_app/app/home/profile/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  int tabindex = 0;

  navigateToOrdersInProgress(int index) {
    setState(() {
      currentIndex = 1; // Set to Orders tab index
    });
    tabindex = index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Dashboard(
        onCardTap: navigateToOrdersInProgress, // Pass the callback
      ),
      Orders(
        initialIndex: tabindex,
      ),
      const Chat(),
      const Profile(),
    ];
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey.shade100,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;

              if (value == 1) {
                tabindex = 0;
              }
              log(currentIndex.toString());
              log(tabindex.toString());
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
              label: 'Orders',
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
          ],
        ),
      ),
    );
  }
}
