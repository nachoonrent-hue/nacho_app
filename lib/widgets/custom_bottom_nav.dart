import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavConfig> _items = [
    _NavConfig(Icons.groups_rounded, 'Dancers'),
    _NavConfig(Icons.celebration_rounded, 'Weddings'),
    _NavConfig(Icons.space_dashboard_rounded, 'My Activity'),
    _NavConfig(Icons.person_rounded, 'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPlum.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / _items.length;

            return SizedBox(
              height: 66,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Sliding indicator pill behind the active icon
                  AnimatedPositioned(
                    duration: AppMotion.medium,
                    curve: AppMotion.spring,
                    left: currentIndex * itemWidth + itemWidth / 2 - 31,
                    top: 5,
                    child: AnimatedContainer(
                      duration: AppMotion.fast,
                      width: 62,
                      height: 34,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryPlum, Color(0xFF6B206C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPlum.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(_items.length, (index) {
                      return Expanded(
                        child: _NavItem(
                          config: _items[index],
                          isSelected: currentIndex == index,
                          onTap: () => onTap(index),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _NavConfig config;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.config,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = isSelected ? Colors.white : AppColors.primaryPlum;
    final labelColor = isSelected
        ? AppColors.primaryPlum
        : AppColors.secondaryText;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: Center(
                child: AnimatedScale(
                  duration: AppMotion.medium,
                  curve: AppMotion.spring,
                  scale: isSelected ? 1.12 : 1.0,
                  child: Icon(config.icon, color: selectedColor, size: 24),
                ),
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: AnimatedDefaultTextStyle(
                duration: AppMotion.fast,
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: labelColor,
                ),
                child: Text(
                  config.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavConfig {
  final IconData icon;
  final String label;

  const _NavConfig(this.icon, this.label);
}
