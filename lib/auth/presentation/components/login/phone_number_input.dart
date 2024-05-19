import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumberDimension = TextPainter(
      text: TextSpan(
        text: '888 - XXXX - XXXX',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Indonesia",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "+62",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: phoneNumberDimension.width,
              ),
              child: TextField(
                inputFormatters: [
                  MaskedInputFormatter("### - #### - ####"),
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration.collapsed(
                  hintText: "888 - XXXX - XXXX",
                  hintStyle:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.2),
                          ),
                  floatingLabelBehavior: null,
                ),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          height: 0.7,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ],
    );
  }
}
