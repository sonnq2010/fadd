import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

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
      title: LocaleKeys.global_components_button_title.tr(),
      description: LocaleKeys.global_components_button_desc.tr(),
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
                        child: Text('With Icons', style: typography.labelSmall),
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
                          child: _buildButton(variant, size, 'Button', () {}),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _buildButton(
                            variant,
                            size,
                            'Button',
                            () {},
                            leading: LucideIcons.arrowLeft,
                            trailing: LucideIcons.arrowRight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.xs),
                          child: _buildButton(variant, size, 'Button', null),
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

  Widget _buildButton(
    AppButtonVariant variant,
    AppButtonSize size,
    String label,
    VoidCallback? onPressed, {
    IconData? leading,
    IconData? trailing,
  }) {
    switch (variant) {
      case AppButtonVariant.primary:
        return AppButton.primary(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
      case AppButtonVariant.secondary:
        return AppButton.secondary(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
      case AppButtonVariant.outline:
        return AppButton.outline(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
      case AppButtonVariant.ghost:
        return AppButton.ghost(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
      case AppButtonVariant.destructive:
        return AppButton.destructive(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
      case AppButtonVariant.destructiveOutline:
        return AppButton.destructiveOutline(
          label: label,
          onPressed: onPressed,
          size: size,
          leadingIcon: leading,
          trailingIcon: trailing,
        );
    }
  }
}
