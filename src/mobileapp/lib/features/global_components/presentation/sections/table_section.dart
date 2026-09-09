import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/data_display/app_avatar.dart';
import 'package:mobileapp/core/widgets/data_display/app_badge.dart';
import 'package:mobileapp/core/widgets/data_display/app_table.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/core/l10n/locale_keys.g.dart';

class TableSection extends StatefulWidget {
  const TableSection({super.key});

  @override
  State<TableSection> createState() => _TableSectionState();
}

class _TableSectionState extends State<TableSection> {
  final Set<int> _selectedIndices = {};

  final List<Map<String, dynamic>> _data = [
    {
      'name': 'Alex Kim',
      'email': 'alex@company.com',
      'initials': 'AK',
      'status': 'Active',
      'badgeVariant': AppBadgeVariant.success,
      'role': 'Admin',
    },
    {
      'name': 'Maria Jones',
      'email': 'maria@company.com',
      'initials': 'MJ',
      'status': 'Pending',
      'badgeVariant': AppBadgeVariant.warning,
      'role': 'Editor',
    },
    {
      'name': 'Ryan Smith',
      'email': 'ryan@company.com',
      'initials': 'RS',
      'status': 'Inactive',
      'badgeVariant': AppBadgeVariant.secondary,
      'role': 'Viewer',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return ComponentCard(
      title: LocaleKeys.global_components_table_title.tr(),
      description: LocaleKeys.global_components_table_desc.tr(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600,
          child: AppTable<Map<String, dynamic>>(
            selectable: true,
            selectedIndices: _selectedIndices,
            onRowSelectionChanged: (index, selected) {
              setState(() {
                if (selected) {
                  _selectedIndices.add(index);
                } else {
                  _selectedIndices.remove(index);
                }
              });
            },
            onSelectAllChanged: (selected) {
              setState(() {
                if (selected) {
                  _selectedIndices.addAll(
                    List.generate(_data.length, (i) => i),
                  );
                } else {
                  _selectedIndices.clear();
                }
              });
            },
            columns: [
              AppTableColumn(
                header: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(LocaleKeys.global_components_table_col_name.tr()),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      LucideIcons.chevronDown,
                      size: 12,
                      color: colors.icon.tertiary,
                    ),
                  ],
                ),
                width: 200,
              ),
              AppTableColumn(
                header: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(LocaleKeys.global_components_table_col_status.tr()),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      LucideIcons.chevronDown,
                      size: 12,
                      color: colors.icon.tertiary,
                    ),
                  ],
                ),
                width: 110,
              ),
              AppTableColumn(
                header: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(LocaleKeys.global_components_table_col_role.tr()),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(
                      LucideIcons.chevronDown,
                      size: 12,
                      color: colors.icon.tertiary,
                    ),
                  ],
                ),
                width: 120,
              ),
              const AppTableColumn(
                header: SizedBox.shrink(),
                width: 56,
                alignment: Alignment.centerRight,
              ),
            ],
            data: _data,
            rowBuilder: (context, item, index) {
              return [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppAvatar(
                      size: AppAvatarSize.s,
                      initials: item['initials'] as String,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item['name'] as String,
                          style: typography.bodySmall.withColor(
                            colors.text.primary,
                          ),
                        ),
                        Text(
                          item['email'] as String,
                          style: typography.caption.withColor(
                            colors.text.tertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppBadge(
                  label: item['status'] as String,
                  variant: item['badgeVariant'] as AppBadgeVariant,
                ),
                Text(
                  item['role'] as String,
                  style: typography.bodySmall.withColor(colors.text.secondary),
                ),
                AppIconButton.ghost(
                  icon: LucideIcons.menu,
                  size: AppButtonSize.small,
                  onPressed: () {},
                  semanticLabel: 'Row actions',
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
