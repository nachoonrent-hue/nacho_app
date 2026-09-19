import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VerificationBadge extends StatelessWidget {
  final double size;
  const VerificationBadge({super.key, this.size = 18.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.saffron,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_rounded,
        color: Colors.white,
        size: size - 4,
      ),
    );
  }
}
