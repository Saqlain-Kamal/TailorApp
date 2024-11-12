import 'package:flutter/material.dart';

import '../../../../../utils/mediaquery.dart';
import '../../customer_dashboard/widgets/tailor_listing_card.dart';

class CustomerFavorite extends StatelessWidget {
  const CustomerFavorite({super.key,});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Tailors"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight(context) * 0.03,
            ),
            Flexible(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return TailorListingCard(
                    name: "Ali Tailor Shop",
                    cityName: "Peshawar",
                    showFavorite: true,
                    image: 'assets/images/avatar3.png',
                    onTap: (){},
                  );
                },
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
