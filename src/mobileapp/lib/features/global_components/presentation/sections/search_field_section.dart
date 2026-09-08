import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/inputs/inputs.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class SearchFieldSection extends StatelessWidget {
  const SearchFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final sizes = [
      (AppSearchFieldSize.large, 'Large (48px)'),
      (AppSearchFieldSize.medium, 'Medium (40px)'),
      (AppSearchFieldSize.small, 'Small (36px)'),
    ];

    return ComponentCard(
      title: 'global_components.search_title'.tr(),
      description: 'global_components.search_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (size, sizeLabel) in sizes) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Text(
                sizeLabel,
                style: typography.labelLarge.withColor(colors.text.primary),
              ),
            ),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.md,
              children: [
                // 1. Default (placeholder)
                SizedBox(
                  width: 240,
                  child: AppSearchField(
                    placeholder: 'global_components.search_placeholder'.tr(),
                    size: size,
                  ),
                ),
                // 2. Filled (with clear button)
                SizedBox(
                  width: 240,
                  child: AppSearchField(
                    initialValue: 'Search query',
                    placeholder: 'global_components.search_placeholder'.tr(),
                    size: size,
                  ),
                ),
                // 3. Disabled
                SizedBox(
                  width: 240,
                  child: AppSearchField(
                    placeholder: 'global_components.search_placeholder'.tr(),
                    enabled: false,
                    size: size,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ],
      ),
    );
  }
}
