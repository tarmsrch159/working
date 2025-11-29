import 'dart:ui';
import 'package:flutter/material.dart';

class ModernCenterButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  Color? backgroundColor;
  double? w_button;
  double? h_button;
  ModernCenterButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.w_button,
    this.h_button,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: h_button ?? 18,
          horizontal: w_button ?? 28,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor ?? Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 14),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
