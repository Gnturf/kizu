// import 'package:flutter/material.dart';
// import 'package:flutter_nodejs_socketio/components/widgets/home_page/group_bar/group_item.dart';
// import 'package:flutter_nodejs_socketio/components/widgets/home_page/group_bar/group_overflow.dart';

// String generateOverflowDesc(int limiter, List<Group> group) {
//   List<String> remainingGroups = [];
//   for (var i = limiter; i < group.length; i++) {
//     remainingGroups.add(group[i].name);
//   }

//   return remainingGroups.join(", ");
// }

// List<Widget> generateGroupItem(List<Group> groupList) {
//   List<Widget> finalItem = [];
//   if (groupList.length < 4) {
//     for (var i = 0; i < groupList.length; i++) {
//       finalItem.add(
//         GroupItem(
//           name: groupList[i].name,
//           desc: groupList[i].desc,
//         ),
//       );
//     }
//   } else {
//     for (var i = 0; i < 4; i++) {
//       finalItem.add(
//         GroupItem(
//           name: groupList[i].name,
//           desc: groupList[i].desc,
//         ),
//       );
//     }

//     finalItem.add(
//       GroupOverflow(
//         overflowDesc: generateOverflowDesc(4, groupList),
//       ),
//     );
//   }

//   return finalItem;
// }
