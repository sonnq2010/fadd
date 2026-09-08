import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.media,
    this.badge,
    required this.title,
    required this.description,
    this.actions = const [],
    this.width = 320.0,
  });

  final Widget? media;
  final Widget? badge;
  final String title;
  final String description;
  final List<Widget> actions;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colors.background.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colors.border.subtle,
          width: 1.0,
        ),
        boxShadow: AppShadows.sm,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Media / Image placeholder
          media ??
              Container(
                height: 160.0,
                width: double.infinity,
                color: colors.background.tertiary,
              ),

          // Card content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badge != null) ...[
                  badge!,
                  const Gap(AppSpacing.sm),
                ],
                Text(
                  title,
                  style: typography.headingH4.withColor(colors.text.primary),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  description,
                  style: typography.bodySmall.withColor(colors.text.secondary),
                ),
                if (actions.isNotEmpty) ...[
                  const Gap(AppSpacing.sm),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < actions.length; i++) ...[
                        if (i > 0) const Gap(AppSpacing.sm),
                        actions[i],
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
