import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/selection/app_chip.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class ChipSection extends StatefulWidget {
  const ChipSection({super.key});

  @override
  State<ChipSection> createState() => _ChipSectionState();
}

class _ChipSectionState extends State<ChipSection> {
  final Set<String> _selectedFilters = {'Design'};

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_chip_title.tr(),
      description: LocaleKeys.global_components_chip_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              AppChip(
                label: 'Default',
                onTap: () {},
              ),
              const AppChip(
                label: 'Selected',
                selected: true,
              ),
              const AppChip(
                label: 'Disabled',
                enabled: false,
              ),
              AppChip(
                label: 'Removable',
                onDeleted: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: ['Design', 'Development', 'Marketing', 'Sales'].map((
              filter,
            ) {
              final isSelected = _selectedFilters.contains(filter);
              return AppChip(
                label: filter,
                selected: isSelected,
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedFilters.remove(filter);
                    } else {
                      _selectedFilters.add(filter);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
