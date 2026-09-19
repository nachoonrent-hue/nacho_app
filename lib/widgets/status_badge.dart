import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label = status.toUpperCase();

    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'completed':
      case 'accepted':
      case 'published':
        bg = AppColors.emeraldSuccess.withValues(alpha: 0.15);
        fg = AppColors.emeraldSuccess;
        break;
      case 'requested':
      case 'paymentpending':
      case 'payment pending':
      case 'pending':
        bg = AppColors.warning.withValues(alpha: 0.15);
        fg = AppColors.warning;
        break;
      case 'cancelled':
      case 'disputed':
      case 'rejected':
        bg = AppColors.errorRed.withValues(alpha: 0.15);
        fg = AppColors.errorRed;
        break;
      case 'draft':
      default:
        bg = AppColors.secondaryText.withValues(alpha: 0.15);
        fg = AppColors.secondaryText;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
