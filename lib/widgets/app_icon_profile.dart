import 'package:flutter/material.dart';

class AppIconProfile extends StatelessWidget {
  final double size; // icon ka total size
  final Color? backgroundColor; // circle background color
  final Color? iconColor; // icon color
  final String? assetPath; // asset image path
  final IconData? iconData; // Flutter icon
  final double padding; // padding inside circle
  final VoidCallback? onTap; // optional tap callback

  const AppIconProfile({
    super.key,
    this.size = 30,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.iconColor,
    this.assetPath,
    this.iconData,
    this.padding = 6,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            // Agar iconData aur assetPath null ho to default back
            if (assetPath == null || iconData == null) {
              Navigator.pop(context);
            }
          },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.transparent, // no background
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black, // border color
            width: 1, // border thickness
          ),
        ),
        child: assetPath != null
            ? Image.asset(assetPath!, fit: BoxFit.contain)
            : Icon(
          iconData ?? Icons.edit, // default back arrow
          color: iconColor,
          size: size - padding * 2,
        ),
      ),
    );
  }
}
