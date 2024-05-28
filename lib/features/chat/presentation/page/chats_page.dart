import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        actions: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_comment_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            width: 18,
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ListView.builder(
          // TODO: Change here
          itemCount: 0,
          itemBuilder: (context, index) {
            // TODO: Uncomment this later
            // return ChatTile(
            //   name: userContactsList[index].displayName,
            //   lastChat: messageHistory.last.messageText,
            //   isRead: index % 2 == 0,
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) {
            //         return ChatScreen(
            //           contactData: userContactsList[index],
            //         );
            //       },
            //     ));
            //   },
            // );
          },
        ),
      ),
    );
  }
}
