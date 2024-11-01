import 'package:flutter/material.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/container_decoration.dart';

class SingleChatCard extends StatelessWidget {
  const SingleChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: reusableBoxDecoration,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/avatar3.png'),
        ),
        title: const Text('Sara Khan'),
        subtitle: Text(
          'Can you confirm the delivery date?',
          style: TextStyle(color: Colors.grey.shade500),
        ),
        trailing: Column(
          children: [
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.darkBlueColor),
              child: const Center(
                child: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('03:54 AM')
          ],
        ),
      ),
    );
  }
}
