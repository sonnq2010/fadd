import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/selection/app_checkbox.dart';

class AppTableColumn {
  const AppTableColumn({
    required this.header,
    this.width,
    this.flex = 1,
    this.alignment = Alignment.centerLeft,
  });

  final Widget header;
  final double? width;
  final int flex;
  final Alignment alignment;
}

class AppTable<T> extends StatelessWidget {
  const AppTable({
    super.key,
    required this.columns,
    required this.data,
    required this.rowBuilder,
    this.selectable = false,
    this.selectedIndices = const {},
    this.onRowSelectionChanged,
    this.onSelectAllChanged,
  });

  final List<AppTableColumn> columns;
  final List<T> data;
  final List<Widget> Function(BuildContext context, T item, int index)
  rowBuilder;
  final bool selectable;
  final Set<int> selectedIndices;
  final void Function(int index, bool selected)? onRowSelectionChanged;
  final void Function(bool selected)? onSelectAllChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final allSelected =
        data.isNotEmpty && selectedIndices.length == data.length;
    final isIndeterminate = selectedIndices.isNotEmpty && !allSelected;

    return Container(
      decoration: BoxDecoration(
        color: colors.background.primary,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border.defaultColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            color: colors.background.secondary,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                if (selectable) ...[
                  SizedBox(
                    width: 40,
                    child: AppCheckbox(
                      value: isIndeterminate
                          ? AppCheckboxValue.indeterminate
                          : (allSelected
                                ? AppCheckboxValue.checked
                                : AppCheckboxValue.unchecked),
                      onChanged: (val) {
                        onSelectAllChanged?.call(
                          val == AppCheckboxValue.checked,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                ],
                ...columns.map((col) {
                  final child = Align(
                    alignment: col.alignment,
                    child: DefaultTextStyle(
                      style: context.typography.labelSmall.withColor(
                        colors.text.tertiary,
                      ),
                      child: col.header,
                    ),
                  );
                  if (col.width != null) {
                    return SizedBox(width: col.width, child: child);
                  }
                  return Expanded(flex: col.flex, child: child);
                }),
              ],
            ),
          ),
          // Rows
          ...data.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = selectedIndices.contains(index);
            final cells = rowBuilder(context, item, index);

            return Container(
              decoration: BoxDecoration(
                color: colors.background.primary,
                border: Border(
                  top: BorderSide(color: colors.border.subtle),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  if (selectable) ...[
                    SizedBox(
                      width: 40,
                      child: AppCheckbox(
                        value: isSelected
                            ? AppCheckboxValue.checked
                            : AppCheckboxValue.unchecked,
                        onChanged: (val) {
                          onRowSelectionChanged?.call(
                            index,
                            val == AppCheckboxValue.checked,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                  ],
                  ...columns.asMap().entries.map((colEntry) {
                    final colIndex = colEntry.key;
                    final col = colEntry.value;
                    final cellWidget = colIndex < cells.length
                        ? cells[colIndex]
                        : const SizedBox.shrink();

                    final child = Align(
                      alignment: col.alignment,
                      child: cellWidget,
                    );
                    if (col.width != null) {
                      return SizedBox(width: col.width, child: child);
                    }
                    return Expanded(flex: col.flex, child: child);
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
