import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          // TODO: Change Here
          "Friends ??",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  hintText: "Name, ID",
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: ListView.builder(
              // TODO: Implement This
              itemCount: 0,
              itemBuilder: (context, index) {
                return null;
              
                // TODO: Implement This
                // return FriendTile(
                //   name: friend.displayName,
                //   desc: friend.statusMessage,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
