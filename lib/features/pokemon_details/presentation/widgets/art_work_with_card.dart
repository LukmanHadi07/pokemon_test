import 'package:flutter/material.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/features/pokemon_details/data/enums/detail_section.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/navigation_arrow.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/pokemon_art_work.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/pokemon_detail_card.dart';

class ArtworkWithCard extends StatelessWidget {
  final DetailSection section;
  final ValueChanged<DetailSection> onSectionChanged;
  final PokemonDetailEntity detail;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  const ArtworkWithCard({
    super.key,
    required this.section,
    required this.onSectionChanged,
    required this.detail,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardPadding = constraints.maxWidth > 360 ? 32.0 : 24.0;

        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 140),
              padding: EdgeInsets.symmetric(
                horizontal: cardPadding,
                vertical: 32,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: AppColors.black.withOpacity(0.1),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: PokemonDetailsCard(
                detail: detail,
                section: section,
                onSectionChanged: onSectionChanged,
                isFavorite: isFavorite,
                onFavoriteToggle: onFavoriteToggle,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 220,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PokemonArtwork(imageUrl: detail.imageUrl),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: NavigationArrow(icon: Icons.chevron_left),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: NavigationArrow(icon: Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
