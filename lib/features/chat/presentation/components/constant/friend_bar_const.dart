import 'package:flutter/material.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/friends_bar/friend_item.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/friends_bar/friend_overflow.dart';

String generateOverflowDesc(int limiter, List<ContactEntity> contact) {
  List<String> remainingGroups = [];
  for (var i = limiter; i < contact.length; i++) {
    remainingGroups.add(contact[i].displayName);
  }

  return remainingGroups.join(", ");
}

List<Widget> generateFriendItem(List<ContactEntity> contactList) {
  List<Widget> finalItem = [];
  if (contactList.length < 4) {
    for (var i = 0; i < contactList.length; i++) {
      finalItem.add(
        FriendItem(
          contactData: contactList[i],
        ),
      );
    }
  } else {
    for (var i = 0; i < 4; i++) {
      finalItem.add(
        FriendItem(
          contactData: contactList[i],
        ),
      );
    }

    finalItem.add(
      FriendOverflow(
        overflowDesc: generateOverflowDesc(4, contactList),
      ),
    );
  }

  return finalItem;
}
