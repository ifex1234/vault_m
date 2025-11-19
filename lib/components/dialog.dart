import 'package:flutter/material.dart';

class CameraDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadiusGeometry? borderRadius;
  final Widget? icon;

  const CameraDialog({
    super.key,
    required this.title,
    required this.message,
    this.actions,
    this.backgroundColor,
    this.contentPadding,
    this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: icon != null ? 36.0 : 0.0),
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).cardColor,
              borderRadius: borderRadius ?? BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding:
                contentPadding ??
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) const SizedBox(height: 36.0),
                Icon(Icons.photo_camera),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),

                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '1',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'Use a well lit area, preferably with the light shinning on your face',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 5, thickness: 2),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '2',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'Make sure your entire face is clear and visible',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(height: 4),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '3',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            'Follow the instruction on the screen and press capture when ready',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: actions!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<T?> showCameraDialog<T>(
  BuildContext context, {
  required String title,
  required String message,
  List<Widget>? actions,
  bool barrierDismissible = true,
  Color? backgroundColor,
  EdgeInsetsGeometry? contentPadding,
  BorderRadiusGeometry? borderRadius,
  Widget? icon,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return CameraDialog(
        title: title,
        message: message,
        actions: actions,
        backgroundColor: backgroundColor,
        contentPadding: contentPadding,
        borderRadius: borderRadius,
        icon: icon,
      );
    },
  );
}
