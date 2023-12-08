import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoinIcon extends StatelessWidget {
  const CoinIcon(this.url, this.size, {super.key});

  final String url;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedNetworkImage(
        imageUrl: url,
        height: size,
        width: size,
        placeholder: (_, __) {
          return Container(color: Colors.grey, height: size, width: size);
        },
        errorWidget: (_, ___, __) {
          return Container(color: Colors.grey, height: size, width: size);
        },
      ),
    );
  }
}
