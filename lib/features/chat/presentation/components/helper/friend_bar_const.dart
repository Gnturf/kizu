import 'package:flutter/material.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/friends_bar/friend_item.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/friends_bar/friend_overflow.dart';

String generateOverflowDesc(int limiter, List<ContactEntity> contactList) {
  List<String> remainingGroups = [];
  for (var i = limiter; i < contactList.length; i++) {
    remainingGroups.add(contactList[i].displayName);
  }

  return remainingGroups.join(", ");
}

List<Widget> generateFriendItem(List<ContactEntity> friendList) {
  List<Widget> finalItem = [];
  if (friendList.length < 4) {
    for (var i = 0; i < friendList.length; i++) {
      finalItem.add(
        FriendItem(
          name: friendList[i].displayName,
          desc: friendList[i].statusMessage ?? "-",
        ),
      );
    }
  } else {
    for (var i = 0; i < 4; i++) {
      finalItem.add(
        FriendItem(
          name: friendList[i].displayName,
          desc: friendList[i].statusMessage ?? "-",
        ),
      );
    }

    finalItem.add(
      FriendOverflow(
        overflowDesc: generateOverflowDesc(4, friendList),
      ),
    );
  }

  return finalItem;
}
