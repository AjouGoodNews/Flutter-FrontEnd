import 'package:flutter/material.dart';
import 'package:goodnews/themes/custom_color.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: primary,
        backgroundColor: Colors.white,
        strokeAlign: BorderSide.strokeAlignInside,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}