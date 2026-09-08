import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/app_pagination.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class PaginationSection extends StatefulWidget {
  const PaginationSection({super.key});

  @override
  State<PaginationSection> createState() => _PaginationSectionState();
}

class _PaginationSectionState extends State<PaginationSection> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.pagination_title'.tr(),
      description: 'global_components.pagination_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // States
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              AppPaginationItem(
                label: '1',
                state: AppPaginationItemState.defaultState,
              ),
              AppPaginationItem(
                label: '1',
                state: AppPaginationItemState.hover,
              ),
              AppPaginationItem(
                label: '1',
                state: AppPaginationItemState.active,
              ),
              AppPaginationItem(
                label: '1',
                state: AppPaginationItemState.disabled,
              ),
              AppPaginationItem(
                label: '...',
                state: AppPaginationItemState.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          // Composite interactive
          AppPagination(
            currentPage: _currentPage,
            totalPages: 12,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ],
      ),
    );
  }
}
