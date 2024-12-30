import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/chat/screens/chat.dart';
import 'package:tailor_app/app/home/dashboard/screens/dashboard.dart';
import 'package:tailor_app/app/home/orders/screens/orders.dart';
import 'package:tailor_app/app/home/profile/screens/profile.dart';
import 'package:tailor_app/app/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.index});
  final int index;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index; // Assign the passed index
  }

  int tabindex = 0;
  Future<bool> _onWillPop() async {
    // Check if the current tab is 0 (Dashboard), and if so, close the app
    if (currentIndex == 0) {
      // Allow app to exit when on the Home tab
      return true;
    } else {
      // Otherwise, return to the Home tab
      setState(() {
        currentIndex = 0; // Set to Home tab
      });
      return false; // Don't close the app, just switch tabs
    } // Default behavior for back press
  }

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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              BottomNavigationBarItem(
                  icon: currentIndex == 3
                      ? const Image(
                          height: 25,
                          image: AssetImage(
                            'assets/images/frame.png',
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
      ),
    );
  }
}
