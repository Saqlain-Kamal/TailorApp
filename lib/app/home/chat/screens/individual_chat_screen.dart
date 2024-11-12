import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tailor_app/app/auth/widgets/custom_text_field.dart';
import 'package:tailor_app/utils/colors.dart';
import 'package:tailor_app/utils/mediaquery.dart';

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen({super.key});

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Function to scroll to the end of the ListView
  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      // At the top or bottom of the list
      log(_scrollController.position.pixels.toString());
      if (_scrollController.position.pixels == 0) {
        // At the bottom

        _showScrollButton.value = false;
      } else {
        // At the bottom of the list, hide the button
        _showScrollButton.value = true;
      }
    } else {
      _showScrollButton.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    log(_showScrollButton.value.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, top: 35),
        child: SizedBox(
          height: screenHeight(context) * 0.99,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/avatar3.png'),
                      ),
                      title: const Text('Sarah Khan'),
                      subtitle: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Online')
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.more_vert)
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      controller: _scrollController,
                      reverse: true,
                      children: const [
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: false,
                        ),
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: false,
                        ),
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: true,
                        ),
                        MessageBubble(
                          message: 'Hello! Nisma ',
                          date: '02:43',
                          isMe: true,
                        ),
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: false,
                        ),
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: false,
                        ),
                        MessageBubble(
                          message: 'Hello! Nisma ',
                          date: '02:43',
                          isMe: false,
                        ),
                        MessageBubble(
                          message:
                              'Hello! I just want to confirm if you have received my order details? ',
                          date: '02:43',
                          isMe: true,
                        ),
                      ],
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _showScrollButton,
                      builder: (context, showButton, child) {
                        return showButton
                            ? Positioned(
                                bottom: 16.0,
                                right: 16.0,
                                child: FloatingActionButton(
                                  onPressed: _scrollToEnd,
                                  child: const Icon(Icons.arrow_downward),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomeTextField(
                      hint: 'Message',
                      controller: messageController,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: screenWidth(context) * 0.13,
                    height: screenHeight(context) * 0.063,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [AppColors.darkBlueColor, AppColors.blueColor],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/send.png',
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.date,
    required this.isMe,
  });

  final String message;
  final String date;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final messageWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
                messageWidth, // Max width, allows container to shrink with shorter text
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          margin: isMe
              ? const EdgeInsets.only(left: 50, right: 10, top: 5, bottom: 5)
              : const EdgeInsets.only(left: 10, right: 50, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: isMe ? AppColors.darkBlueColor : Colors.grey.shade100,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isMe ? AppColors.whiteColor : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  date,
                  style: TextStyle(
                    color: isMe ? AppColors.whiteColor : Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
