import 'package:flutter/material.dart';
import 'package:kizu/features/auth/presentation/components/login/OTPInput/otp_single_text_field.dart';

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

    final focusNodeOTP1 = FocusNode();
    final focusNodeOTP2 = FocusNode();
    final focusNodeOTP3 = FocusNode();
    final focusNodeOTP4 = FocusNode();
    final focusNodeOTP5 = FocusNode();
    final focusNodeOTP6 = FocusNode();

    return SizedBox(
      width: (otpNumberDimension.width + 8) * 6 + (14 * 5),
      child: Form(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OTPSingleTextField(
              focusNode: focusNodeOTP1,
              nextNode: focusNodeOTP2,
            ),
            OTPSingleTextField(
              focusNode: focusNodeOTP2,
              prevNode: focusNodeOTP1,
              nextNode: focusNodeOTP3,
            ),
            OTPSingleTextField(
              focusNode: focusNodeOTP3,
              prevNode: focusNodeOTP2,
              nextNode: focusNodeOTP4,
            ),
            OTPSingleTextField(
              focusNode: focusNodeOTP4,
              prevNode: focusNodeOTP3,
              nextNode: focusNodeOTP5,
            ),
            OTPSingleTextField(
              focusNode: focusNodeOTP5,
              prevNode: focusNodeOTP4,
              nextNode: focusNodeOTP6,
            ),
            OTPSingleTextField(
              focusNode: focusNodeOTP6,
              prevNode: focusNodeOTP5,
            ),
          ],
        ),
      ),
    );
  }
}
