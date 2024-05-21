import 'package:flutter/material.dart';

class CountrySelect extends StatelessWidget {
  const CountrySelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              print("Clicked");
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Indonesia",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          "Please select the country or region where you live",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}
