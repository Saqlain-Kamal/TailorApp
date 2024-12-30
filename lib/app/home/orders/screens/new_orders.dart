import 'package:flutter/material.dart';
import 'package:tailor_app/app/utils/colors.dart';
import 'package:tailor_app/app/utils/constants.dart';
import 'package:tailor_app/app/utils/container_decoration.dart';
import 'package:tailor_app/app/utils/custom_button.dart';

class NewOrders extends StatelessWidget {
  const NewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/avatar3.png'),
              ),
              title: Text('Sarah Khan'),
              subtitle: Text('Custom Suit'),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              AppStrings.orderSummary,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: reusableBoxDecoration,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.orderId,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      const Text(
                        '1234',
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.borderGreyColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.orderDate,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      const Text(
                        '01/10/24',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.price,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      const Text(
                        '2000',
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColors.borderGreyColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.deliveryDate,
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                      const Text(
                        '15/10/24',
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {},
                    text: 'ACCEPT',
                    firstColor: Colors.green.shade600,
                    secondColor: Colors.green.shade600,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomButton(
                    onTap: () {},
                    text: 'REJECT',
                    firstColor: Colors.red,
                    secondColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
