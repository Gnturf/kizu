import 'package:flutter/material.dart';

import 'package:kizu/features/chat/presentation/components/widgets/chat_screen/app_bar/chat_app_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/chat_screen/input_chat/input_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Widget> widgetChatLog;

  // TODO: Implement This
  // List<Widget> initializingChat() {
  //   final List<Widget> tempChatWidget = [];
  //   for (final chatData in messageHistory) {
  //     if (chatData.senderId == userData.id) {
  //       tempChatWidget.add(
  //         SentMessage(
  //           message: chatData.messageText,
  //           isRead: false,
  //           sendAt: chatData.sentAt,
  //         ),
  //       );
  //     } else if (chatData.senderId == widget.contactData.id) {
  //       tempChatWidget.add(
  //         ReceivedMessage(message: chatData.messageText),
  //       );
  //     }
  //   }

  //   return tempChatWidget;
  // }

  @override
  void initState() {
    super.initState();

    // TODO: Change Here
    // widgetChatLog = initializingChat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print("Clicked");
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: chatScreenAppBar(context),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: (52 + 24),
                  ),
                  child: Column(
                    // TODO: Repair this
                    children: [],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: InputChat(
                  onSent: (text) {
                    // TODO: Implement This
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
