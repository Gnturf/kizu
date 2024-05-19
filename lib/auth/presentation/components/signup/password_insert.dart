import 'package:flutter/material.dart';

class PasswordInsert extends StatefulWidget {
  const PasswordInsert({
    super.key,
    required this.hintText,
    this.errorText,
    required this.controller,
  });

  final String hintText;
  final String? errorText;
  final TextEditingController controller;

  @override
  State<PasswordInsert> createState() => _PasswordInsertState();
}

class _PasswordInsertState extends State<PasswordInsert> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscured,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
      decoration: InputDecoration(
        errorText: widget.errorText,
        errorStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscured = isObscured ? false : true;
            });
          },
          icon: Icon(
            Icons.visibility_outlined,
            color: isObscured
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
