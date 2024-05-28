import 'package:flutter/material.dart';

class InputChat extends StatelessWidget {
  InputChat({super.key, required this.onSent});

  final Function(String text) onSent;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // constraints: BoxConstraints(
      //   maxHeight: (textDimension.height * 5) + 24,
      //   minHeight: textDimension.height + 24,
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Flexible(
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    // This one here
                    Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        maxLines: 4,
                        minLines: 1,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration.collapsed(
                          hintText: "Type Something",
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              String text = _controller.text.trim();
              if (text.isNotEmpty) {
                onSent(text);
              }
            },
            child: Ink(
              color: Theme.of(context).colorScheme.background,
              child: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
