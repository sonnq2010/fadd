import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';

import 'package:mobileapp/core/theme/app_radius.dart';

enum AppAvatarSize {
  xs,
  s,
  m,
  l,
  xl,
}

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.initials,
    this.imageUrl,
    this.image,
    this.size = AppAvatarSize.m,
    this.showStatus = false,
    this.statusColor,
  });

  final String? initials;
  final String? imageUrl;
  final ImageProvider? image;
  final AppAvatarSize size;
  final bool showStatus;
  final Color? statusColor;

  double get dimension {
    switch (size) {
      case AppAvatarSize.xs:
        return 20.0;
      case AppAvatarSize.s:
        return 28.0;
      case AppAvatarSize.m:
        return 36.0;
      case AppAvatarSize.l:
        return 48.0;
      case AppAvatarSize.xl:
        return 64.0;
    }
  }

  double get fontSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 9.0;
      case AppAvatarSize.s:
        return 11.0;
      case AppAvatarSize.m:
        return 12.0;
      case AppAvatarSize.l:
        return 16.0;
      case AppAvatarSize.xl:
        return 20.0;
    }
  }

  double get statusDotSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 6.0;
      case AppAvatarSize.s:
        return 8.0;
      case AppAvatarSize.m:
        return 10.0;
      case AppAvatarSize.l:
        return 13.0;
      case AppAvatarSize.xl:
        return 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    Widget content;

    if (image != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Image(
          image: image!,
          fit: BoxFit.cover,
          width: dimension,
          height: dimension,
        ),
      );
    } else if (imageUrl != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: dimension,
          height: dimension,
          errorBuilder: (_, __, ___) => _buildInitials(colors, typography),
        ),
      );
    } else {
      content = _buildInitials(colors, typography);
    }

    if (!showStatus) {
      return SizedBox(
        width: dimension,
        height: dimension,
        child: content,
      );
    }

    final activeStatusColor = statusColor ?? colors.background.success;

    return SizedBox(
      width: dimension,
      height: dimension,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: content),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              key: const Key('app_avatar_status_dot'),
              width: statusDotSize,
              height: statusDotSize,
              decoration: BoxDecoration(
                color: activeStatusColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.background.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitials(AppColors colors, dynamic typography) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        color: colors.background.brand,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials ?? '',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: colors.text.onBrand,
        ),
      ),
    );
  }
}
