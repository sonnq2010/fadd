import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/buttons/buttons.dart';
import 'package:mobileapp/core/widgets/overlays/overlays.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class ModalSection extends StatelessWidget {
  const ModalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.modal_title'.tr(),
      description: 'global_components.modal_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Static modal card
          AppModalCard(
            title: 'global_components.modal_sample_title'.tr(),
            description: 'global_components.modal_sample_desc'.tr(),
            cancelLabel: 'global_components.cancel'.tr(),
            confirmLabel: 'global_components.modal_delete'.tr(),
            onClose: () {},
            onCancel: () {},
            onConfirm: () {},
          ),
          const SizedBox(height: AppSpacing.lg),
          // Interactive trigger
          AppButton.secondary(
            label: 'Open Modal Dialog',
            size: AppButtonSize.small,
            onPressed: () {
              showAppModal<void>(
                context: context,
                child: AppModalCard(
                  title: 'global_components.modal_sample_title'.tr(),
                  description: 'global_components.modal_sample_desc'.tr(),
                  cancelLabel: 'global_components.cancel'.tr(),
                  confirmLabel: 'global_components.modal_delete'.tr(),
                  onClose: () => Navigator.of(context).pop(),
                  onCancel: () => Navigator.of(context).pop(),
                  onConfirm: () => Navigator.of(context).pop(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
