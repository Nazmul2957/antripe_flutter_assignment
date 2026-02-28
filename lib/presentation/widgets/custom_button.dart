import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final double borderRadius;
  final bool fullWidth;
  final bool isOutlined;
  final Color borderColor; // border color
  final double borderWidth; // border width
  final String? svgIconPath; // optional SVG icon
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.gradient,
    this.textColor,
    this.borderRadius = 12,
    this.fullWidth = true,
    this.isOutlined = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.svgIconPath,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (svgIconPath != null) ...[
          SvgPicture.asset(
            svgIconPath!,
            height: height * 0.5,
            width: height * 0.5,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: TextStyle(
            color: textColor ?? (isOutlined ? borderColor : Colors.white),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final button = Container(
      height: height,
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : backgroundColor,
        gradient: isOutlined ? null : gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor, // always show border
          width: borderWidth,
        ),
      ),
      child: Center(child: buttonChild),
    );

    return GestureDetector(onTap: onPressed, child: button);
  }
}
