import 'package:flutter/material.dart';

class DisplaySubtitleText extends StatelessWidget {
  const DisplaySubtitleText(
      {super.key,
      required this.displayText,
      this.displayText2,
      this.child,
      this.subtitleText,
      this.subtitleChildSpace = 0});

  final String displayText;
  final String? displayText2;
  final String? subtitleText;
  final Widget? child;
  final double subtitleChildSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.left,
        ),
        displayText2 != null
            ? Text(
                displayText2!,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.left,
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        subtitleText != null
            ? Text(
                subtitleText!,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6),
                    ),
              )
            : Container(),
        SizedBox(
          height: subtitleChildSpace,
        ),
        child != null ? child! : Container(),
      ],
    );
  }
}
