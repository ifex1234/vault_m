import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.initials,
    this.radius = 44.0,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else if (initials != null && initials!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        child: Text(
          initials!,
          style:
              textStyle ??
              TextStyle(fontSize: radius * 0.5, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        foregroundColor: foregroundColor ?? Colors.grey[700],
        child: Icon(Icons.person, size: radius * 1.2),
      );
    }
  }
}
