import 'package:flutter/material.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/detail_row.dart';

class AboutContent extends StatelessWidget {
  const AboutContent({super.key, required this.detail});

  final PokemonDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    String formatDecimal(double value) =>
        value.toStringAsFixed(1).replaceAll('.', ',');

    final heightLabel = '${formatDecimal(detail.heightMeters)} m';
    final weightLabel = '${formatDecimal(detail.weightKilograms)} Kg';
    final abilitiesLabel = detail.abilities.isNotEmpty
        ? detail.abilities.join(', ')
        : '--';
    final speciesLabel = detail.species.isNotEmpty ? detail.species : '--';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DetailRow(label: 'Species', value: speciesLabel),
        const SizedBox(height: 12),
        DetailRow(label: 'Height', value: heightLabel),
        const SizedBox(height: 12),
        DetailRow(label: 'Weight', value: weightLabel),
        const SizedBox(height: 12),
        DetailRow(label: 'Abilities', value: abilitiesLabel),
      ],
    );
  }
}
