import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const CachedImage(
      {super.key, required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill)),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey,
        child: const Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.black,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
