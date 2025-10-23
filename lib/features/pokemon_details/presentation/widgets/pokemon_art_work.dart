import 'package:flutter/material.dart';

class PokemonArtwork extends StatelessWidget {
  const PokemonArtwork({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0x33FFFFFF),
      ),
      alignment: Alignment.center,
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 96, color: Colors.grey),
            )
          : const Icon(Icons.broken_image, size: 96, color: Colors.grey),
    );
  }
}
