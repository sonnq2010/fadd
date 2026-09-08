import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class BottomTabSection extends StatefulWidget {
  const BottomTabSection({super.key});

  @override
  State<BottomTabSection> createState() => _BottomTabSectionState();
}

class _BottomTabSectionState extends State<BottomTabSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: LocaleKeys.global_components_bottom_tab_item_title.tr(),
      description: LocaleKeys.global_components_bottom_tab_item_desc.tr(),
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
            spacing: AppSpacing.xxl,
            children: const [
              _StatePreview(
                label: 'Default',
                child: AppBottomTabItem(
                  icon: LucideIcons.house,
                  label: 'Home',
                ),
              ),
              _StatePreview(
                label: 'Active',
                child: AppBottomTabItem(
                  icon: LucideIcons.house,
                  label: 'Home',
                  isActive: true,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              'Mobile / Bottom Tab Bar',
              style: typography.labelLarge.withColor(colors.text.primary),
            ),
          ),
          const Gap(AppSpacing.sm),
          SizedBox(
            width: 375.0,
            child: AppBottomTabBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                AppBottomTabItemData(icon: LucideIcons.house, label: 'Home'),
                AppBottomTabItemData(icon: LucideIcons.search, label: 'Search'),
                AppBottomTabItemData(
                  icon: LucideIcons.bell,
                  label: 'Notifications',
                ),
                AppBottomTabItemData(icon: LucideIcons.mail, label: 'Messages'),
                AppBottomTabItemData(icon: LucideIcons.user, label: 'Profile'),
              ],
            ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
