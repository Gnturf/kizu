import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

enum FocusStatus {
  focused,
  empty,
  filled,
}

class OTPSingleTextField extends StatefulWidget {
  const OTPSingleTextField({
    super.key,
    required this.focusNode,
    this.prevNode,
    this.nextNode,
  });

  final FocusNode focusNode;
  final FocusNode? prevNode;
  final FocusNode? nextNode;

  @override
  State<StatefulWidget> createState() => _OTPSingleTextFieldState();
}

class _OTPSingleTextFieldState extends State<OTPSingleTextField> {
  final _controller = TextEditingController();
  final _otpNumberDimension = TextPainter(
    text: TextSpan(
      text: '0',
      style: TextStyle(
        fontFamily: GoogleFonts.roboto(
          fontWeight: FontWeight.w500,
        ).fontFamily,
        fontSize: 28,
        color: const Color.fromRGBO(235, 200, 119, 1),
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
  FocusStatus _focusState = FocusStatus.empty;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(focusChangeListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(focusChangeListener);
  }

  void focusChangeListener() {
    bool isFocused = widget.focusNode.hasFocus;
    setState(() {
      _focusState = isFocused
          ? FocusStatus.focused
          : (_controller.text.isEmpty ? FocusStatus.empty : FocusStatus.filled);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _otpNumberDimension.width + 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (value) {
              if (value is KeyDownEvent &&
                  value.logicalKey == LogicalKeyboardKey.backspace) {
                if (_controller.text.isEmpty) {
                  FocusScope.of(context).requestFocus(widget.prevNode);
                }
              }
            },
            child: TextFormField(
              controller: _controller,
              focusNode: widget.focusNode,
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration.collapsed(
                hintText: "",
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ).copyWith(counterText: ''),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  if (widget.nextNode == null) {
                    widget.focusNode.unfocus();
                  }
                  FocusScope.of(context).requestFocus(widget.nextNode);
                }
              },
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: _focusState == FocusStatus.empty
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                  : _focusState == FocusStatus.focused
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(100),
            ),
          )
        ],
      ),
    );
  }
}
