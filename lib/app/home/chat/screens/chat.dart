import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/app/extension/padding.dart';
import 'package:tailor_app/app/home/chat/screens/individual_chat_screen.dart';
import 'package:tailor_app/app/home/chat/widgets/single_chat_card.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const CustomeTextField(
              hint: 'Search messages',
              prefixIcon: 'assets/images/Search.png',
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const IndividualChatScreen(),
                              ));
                        },
                        child: const SingleChatCard().paddingOnly(top: 8));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
