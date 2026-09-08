import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/widgets/navigation/navigation.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';
import 'package:mobileapp/generated/locale_keys.g.dart';

class ActionSheetSection extends StatelessWidget {
  const ActionSheetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: LocaleKeys.global_components_action_sheet_title.tr(),
      description: LocaleKeys.global_components_action_sheet_desc.tr(),
      child: Center(
        child: AppActionSheet(
          actions: [
            AppActionSheetItem(label: 'Share', onTap: () {}),
            AppActionSheetItem(label: 'Add to favorites', onTap: () {}),
            AppActionSheetItem(label: 'Duplicate', onTap: () {}),
            AppActionSheetItem(label: 'Report', onTap: () {}),
          ],
          cancelLabel: 'Cancel',
          onCancel: () {},
        ),
      ),
    );
  }
}
