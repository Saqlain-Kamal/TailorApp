import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/container_decoration.dart';
import '../../../../../utils/custom_button.dart';
import '../../../../../utils/mediaquery.dart';

class CustomerPayment extends StatefulWidget {
   CustomerPayment({super.key});

  @override
  State<CustomerPayment> createState() => _CustomerPaymentState();
}

class _CustomerPaymentState extends State<CustomerPayment> {
  int selectedContainer = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method',style: TextStyle(fontSize: 20),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: screenHeight(context)*0.02,),
            customContainer(context,"Easypaisa",(){
              setState(() {
                selectedContainer = 0;
              });
            },0),
            SizedBox(height: screenHeight(context)*0.01,),
            customContainer(context,"Wallet",(){
              setState(() {
                selectedContainer = 1;
              });
            },1),
            Spacer(),
            CustomButton(
              text: "Pay Now",
              onTap: (){},
            ),
            SizedBox(height: screenHeight(context)*0.02,),
          ],
        ),

      ),
    );
  }

  GestureDetector customContainer(BuildContext context,String text,void Function() onTap,int index) {
    return GestureDetector(
            onTap: onTap,
            child: Container(
              width: screenWidth(context) * 0.9,
              height: screenHeight(context) * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                  border: GradientBoxBorder(
                    gradient: LinearGradient(
                      colors: [
                        index == selectedContainer? AppColors.darkBlueColor : AppColors.borderGreyColor,
                        index == selectedContainer? AppColors.lightkBlueColor : AppColors.borderGreyColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                color: AppColors.whiteColor
              ),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
  }
}
