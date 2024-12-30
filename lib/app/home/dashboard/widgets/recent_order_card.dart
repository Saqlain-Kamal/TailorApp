import 'package:flutter/material.dart';
import 'package:tailor_app/app/home/dashboard/widgets/recent_orders_button.dart';
import 'package:tailor_app/app/utils/colors.dart';

class RecentOrdersCard extends StatelessWidget {
 const RecentOrdersCard({
    super.key,
    required this.status,
    this.showBtn = true,
  });
  final String status;
  final bool showBtn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: AppColors.borderGreyColor)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar3.png'),
                radius: 30,
              ),
              title: const Text('Sarah Khan'),
              subtitle: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Custom Suit'),
                  Text('Delivery Date: oct 15,2024')
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: status == 'In Progress'
                        ? AppColors.blueColor
                        : status == 'Pending'
                            ? AppColors.goldenColor
                            : Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const RecentOrdersButton(
                  text: 'View Details',
                ),
                if(showBtn)
                  const SizedBox(
                  width: 25,
                ),
                if(showBtn)
                const RecentOrdersButton(
                  text: 'Update Status',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
