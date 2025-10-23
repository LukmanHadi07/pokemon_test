import 'package:flutter/material.dart';
import 'package:pokemon_test/core/theme/color.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_detail_entity.dart';
import 'package:pokemon_test/features/pokemon_details/domain/entities/pokemon_stat_entity.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/hp_state_row.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/start_bar_row.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/stat_config.dart';

class BaseStateContent extends StatelessWidget {
  final PokemonDetailEntity detail;
  const BaseStateContent({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    final statConfigs = <StatConfig>[
      StatConfig(key: 'attack', label: 'Attack', color: AppColors.pinkCoral),
      StatConfig(
        key: 'defense',
        label: 'Defense',
        color: AppColors.goldenYellow,
      ),
      StatConfig(
        key: 'special-attack',
        label: 'Special Attack',
        color: AppColors.tealGreen,
      ),
      StatConfig(
        key: 'special-defense',
        label: 'Special Defense',
        color: AppColors.goldenYellow,
      ),
      StatConfig(key: 'speed', label: 'Speed', color: AppColors.tealGreen),
    ];

    final children = <Widget>[
      HpStatRow(stat: _findStat('hp')),
      const SizedBox(height: 16),
    ];

    for (var i = 0; i < statConfigs.length; i++) {
      final config = statConfigs[i];
      final stat = _findStat(config.key);
      children
        ..add(
          StatBarRow(
            label: config.label,
            value: _statProgress(stat?.value ?? 0),
            color: config.color,
          ),
        )
        ..add(const SizedBox(height: 12));
    }

    children.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  PokemonStatEntity? _findStat(String key) {
    try {
      return detail.stats.firstWhere((stat) => stat.name == key);
    } catch (_) {
      return null;
    }
  }

  double _statProgress(int value) {
    const maxBaseStat = 255;
    return (value / maxBaseStat).clamp(0, 1);
  }
}
