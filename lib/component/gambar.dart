import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Gambar extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String title;
  const Gambar({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: title,
      ),
    );
  }
}
