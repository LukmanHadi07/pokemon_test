import 'package:flutter/material.dart';
import 'package:pokemon_test/features/pokemon_details/data/enums/detail_section.dart';
import 'package:pokemon_test/features/pokemon_details/presentation/widgets/tab_pill.dart';

class InfoTabs extends StatelessWidget {
  final DetailSection section;
  final ValueChanged<DetailSection> onSectionChanged;
  const InfoTabs({
    super.key,
    required this.section,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TabPill(
          label: 'About',
          isActive: section == DetailSection.about,
          onTap: () => onSectionChanged(DetailSection.about),
        ),
        const SizedBox(width: 16),
        TabPill(
          label: 'Base State',
          isActive: section == DetailSection.baseState,
          onTap: () => onSectionChanged(DetailSection.baseState),
        ),
      ],
    );
  }
}
