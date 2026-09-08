import 'package:flutter/material.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return Container(
      height: 56.0,
      decoration: BoxDecoration(
        color: colors.background.primary,
        border: Border(
          bottom: BorderSide(
            color: colors.border.subtle,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: leading != null ? Center(child: leading!) : null,
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: typography.headingH4.withColor(colors.text.primary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: trailing != null ? Center(child: trailing!) : null,
          ),
        ],
      ),
    );
  }
}
