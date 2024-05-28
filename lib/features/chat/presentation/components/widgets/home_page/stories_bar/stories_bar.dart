import 'package:flutter/material.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/stories_bar/create_stories.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      minVerticalPadding: 10,
      child: ExpansionTile(
        initiallyExpanded: true,
        enableFeedback: false,
        shape: const Border(),
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        tilePadding: const EdgeInsets.all(0),
        childrenPadding: const EdgeInsets.all(0),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.centerLeft,
        title: Text(
          "Stories 0",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
              ),
        ),
        children: const [
          SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Upload Stories
                CreateStories(),
                SizedBox(
                  width: 8,
                ),
                // ...generateStoryItem(storyList),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
