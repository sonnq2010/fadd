import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/navigation/app_breadcrumb.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class BreadcrumbSection extends StatelessWidget {
  const BreadcrumbSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.breadcrumb_title'.tr(),
      description: 'global_components.breadcrumb_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          // States
          Wrap(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppBreadcrumbItem(
                label: 'Default',
                state: AppBreadcrumbItemState.defaultState,
              ),
              AppBreadcrumbItem(
                label: 'Hover',
                state: AppBreadcrumbItemState.hover,
              ),
              AppBreadcrumbItem(
                label: 'Current',
                state: AppBreadcrumbItemState.current,
                showSeparator: false,
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          // Composite trail
          AppBreadcrumb(
            items: [
              AppBreadcrumbItemData(label: 'Home'),
              AppBreadcrumbItemData(label: 'Projects'),
              AppBreadcrumbItemData(label: 'Design System', isCurrent: true),
            ],
          ),
        ],
      ),
    );
  }
}
