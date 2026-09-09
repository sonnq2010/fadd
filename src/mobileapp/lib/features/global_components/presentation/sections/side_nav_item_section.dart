import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class SideNavItemSection extends StatelessWidget {
  const SideNavItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: LocaleKeys.global_components_side_nav_item_title.tr(),
      description: LocaleKeys.global_components_side_nav_item_desc.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'States',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          const Gap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: const [
              _StatePreview(
                label: 'Default',
                child: AppSideNavItem(
                  icon: LucideIcons.house,
                  label: 'Nav item',
                ),
              ),
              _StatePreview(
                label: 'Hover',
                child: AppSideNavItem(
                  icon: LucideIcons.house,
                  label: 'Nav item',
                ),
              ),
              _StatePreview(
                label: 'Active',
                child: AppSideNavItem(
                  icon: LucideIcons.house,
                  label: 'Nav item',
                  isActive: true,
                ),
              ),
              _StatePreview(
                label: 'Disabled',
                child: AppSideNavItem(
                  icon: LucideIcons.house,
                  label: 'Nav item',
                  enabled: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatePreview extends StatelessWidget {
  const _StatePreview({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: typography.caption.withColor(colors.text.secondary),
        ),
        const Gap(AppSpacing.xs),
        child,
      ],
    );
  }
}
