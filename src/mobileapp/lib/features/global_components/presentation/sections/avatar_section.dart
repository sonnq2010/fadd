import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/widgets/data_display/data_display.dart';
import 'package:mobileapp/features/global_components/presentation/widgets/component_card.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'global_components.avatar_title'.tr(),
      description: 'global_components.avatar_desc'.tr(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Initials (XL to XS)'),
          Gap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.lg,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppAvatar(initials: 'JD', size: AppAvatarSize.xl),
              AppAvatar(initials: 'JD', size: AppAvatarSize.l),
              AppAvatar(initials: 'JD', size: AppAvatarSize.m),
              AppAvatar(initials: 'JD', size: AppAvatarSize.s),
              AppAvatar(initials: 'JD', size: AppAvatarSize.xs),
            ],
          ),
          Gap(AppSpacing.lg),
          Text('With Status Indicator'),
          Gap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.lg,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AppAvatar(
                initials: 'JD',
                size: AppAvatarSize.xl,
                showStatus: true,
              ),
              AppAvatar(
                initials: 'JD',
                size: AppAvatarSize.l,
                showStatus: true,
              ),
              AppAvatar(
                initials: 'JD',
                size: AppAvatarSize.m,
                showStatus: true,
              ),
              AppAvatar(
                initials: 'JD',
                size: AppAvatarSize.s,
                showStatus: true,
              ),
              AppAvatar(
                initials: 'JD',
                size: AppAvatarSize.xs,
                showStatus: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
