import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class IconButtonSection extends StatelessWidget {
  const IconButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    final sizes = [
      (AppButtonSize.large, 'Large (48px)'),
      (AppButtonSize.medium, 'Medium (40px)'),
      (AppButtonSize.small, 'Small (36px)'),
    ];

    return ComponentCard(
      title: 'global_components.icon_button_title'.tr(),
      description: 'global_components.icon_button_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (size, sizeLabel) in sizes) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                sizeLabel,
                style: typography.labelLarge.withColor(colors.text.primary),
              ),
            ),
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
                        child: Text('Variant', style: typography.labelSmall),
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
                  for (final variant in AppButtonVariant.values)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: Text(
                            variant.name,
                            style: typography.bodySmall,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _buildIconButton(
                            variant,
                            size,
                            LucideIcons.plus,
                            () {},
                            semanticLabel: '${variant.name} icon button',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _buildIconButton(
                            variant,
                            size,
                            LucideIcons.plus,
                            null,
                            semanticLabel:
                                '${variant.name} disabled icon button',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const Divider(),
          ],
        ],
      ),
    );
  }

  Widget _buildIconButton(
    AppButtonVariant variant,
    AppButtonSize size,
    IconData icon,
    VoidCallback? onPressed, {
    String? semanticLabel,
  }) {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppIconButton.primary(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
      case AppButtonVariant.secondary:
        return AppIconButton.secondary(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
      case AppButtonVariant.outline:
        return AppIconButton.outline(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
      case AppButtonVariant.ghost:
        return AppIconButton.ghost(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
      case AppButtonVariant.destructive:
        return AppIconButton.destructive(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
      case AppButtonVariant.destructiveOutline:
        return AppIconButton.destructiveOutline(
          icon: icon,
          onPressed: onPressed,
          size: size,
          semanticLabel: semanticLabel,
        );
    }
  }
}
