import 'package:flutter/material.dart';
import 'package:kizu/auth/presentation/components/login/OTPInput/otp_single_text_field.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({super.key});

  @override
  State<OTPInput> createState() {
    return _OTPInputState();
  }
}

class _OTPInputState extends State<OTPInput> {
  @override
  Widget build(BuildContext context) {
    final otpNumberDimension = TextPainter(
      text: TextSpan(
        text: '0',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final _focusNodeOTP1 = FocusNode();
    final _focusNodeOTP2 = FocusNode();
    final _focusNodeOTP3 = FocusNode();
    final _focusNodeOTP4 = FocusNode();
    final _focusNodeOTP5 = FocusNode();
    final _focusNodeOTP6 = FocusNode();

    return SizedBox(
      width: (otpNumberDimension.width + 8) * 6 + (14 * 5),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OTPSingleTextField(
              focusNode: _focusNodeOTP1,
              nextNode: _focusNodeOTP2,
            ),
            OTPSingleTextField(
              focusNode: _focusNodeOTP2,
              prevNode: _focusNodeOTP1,
              nextNode: _focusNodeOTP3,
            ),
            OTPSingleTextField(
              focusNode: _focusNodeOTP3,
              prevNode: _focusNodeOTP2,
              nextNode: _focusNodeOTP4,
            ),
            OTPSingleTextField(
              focusNode: _focusNodeOTP4,
              prevNode: _focusNodeOTP3,
              nextNode: _focusNodeOTP5,
            ),
            OTPSingleTextField(
              focusNode: _focusNodeOTP5,
              prevNode: _focusNodeOTP4,
              nextNode: _focusNodeOTP6,
            ),
            OTPSingleTextField(
              focusNode: _focusNodeOTP6,
              prevNode: _focusNodeOTP5,
            ),
          ],
        ),
      ),
    );
  }
}
