import 'package:flutter/material.dart';
import 'package:pokemon_test/features/pokemon_details/data/enums/detail_section.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/about_content.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/base_state_content.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/btn_favorite.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/info_tabs.dart';

class PokemonDetailsCard extends StatelessWidget {
  final PokemonDetailEntity detail;
  final DetailSection section;
  final ValueChanged<DetailSection> onSectionChanged;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const PokemonDetailsCard({
    super.key,
    required this.detail,
    required this.section,
    required this.onSectionChanged,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Text(
          detail.displayName,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          detail.typesLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 28),
        InfoTabs(section: section, onSectionChanged: onSectionChanged),
        const SizedBox(height: 32),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: section == DetailSection.about
              ? AboutContent(key: const ValueKey('about'), detail: detail)
              : BaseStateContent(
                  key: const ValueKey('baseState'),
                  detail: detail,
                ),
        ),
        const SizedBox(height: 36),
        FavoriteButton(isFavorite: isFavorite, onPressed: onFavoriteToggle),
      ],
    );
  }
}
