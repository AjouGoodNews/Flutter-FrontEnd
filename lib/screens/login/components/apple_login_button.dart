import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_decoration.dart';

class AppleLoginButton extends StatelessWidget {
  const AppleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: 46),
      padding: const EdgeInsets.symmetric(vertical: defaultGapM),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logos/apple_white.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(width: defaultGapS),
          const Text(
            'Apple로 계속하기',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}