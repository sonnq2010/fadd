import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class FabSection extends StatelessWidget {
  const FabSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final sizes = [
      (AppFabSize.large, 'Large (72px)'),
      (AppFabSize.medium, 'Medium (56px)'),
      (AppFabSize.small, 'Small (40px)'),
    ];

    return ComponentCard(
      title: LocaleKeys.global_components_fab_title.tr(),
      description: LocaleKeys.global_components_fab_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Text('Size', style: typography.labelSmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Text('Default', style: typography.labelSmall),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Text('Disabled', style: typography.labelSmall),
                    ),
                  ],
                ),
                for (final (size, label) in sizes)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.xs),
                        child: Text(
                          label,
                          style: typography.bodySmall.withColor(
                            colors.text.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: AppFab(
                          icon: LucideIcons.plus,
                          size: size,
                          onPressed: () {},
                          semanticLabel: '$label FAB',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: AppFab(
                          icon: LucideIcons.plus,
                          size: size,
                          onPressed: null,
                          semanticLabel: '$label disabled FAB',
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
