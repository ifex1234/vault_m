import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  const AvatarWidget({
    Key? key,
    this.imageUrl,
    this.initials,
    this.radius = 44.0, // Default radius
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      // Display image if imageUrl is provided
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        backgroundImage: NetworkImage(imageUrl!),
      );
    } else if (initials != null && initials!.isNotEmpty) {
      // Display initials if no image and initials are provided
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        child: Text(
          initials!,
          style:
              textStyle ??
              TextStyle(
                fontSize: radius * 0.5, // Adjust font size based on radius
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    } else {
      // Fallback to a default icon if no image or initials
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.grey[300],
        foregroundColor: foregroundColor ?? Colors.grey[700],
        child: Icon(
          Icons.person,
          size: radius * 1.2, // Adjust icon size based on radius
        ),
      );
    }
  }
}
