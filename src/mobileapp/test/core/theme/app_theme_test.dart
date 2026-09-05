import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileapp/core/theme/app_color.dart';
import 'package:mobileapp/core/theme/app_color_scheme.dart';
import 'package:mobileapp/core/theme/app_gradient.dart';
import 'package:mobileapp/core/theme/app_radius.dart';
import 'package:mobileapp/core/theme/app_shadow.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/core/theme/app_theme.dart';
import 'package:mobileapp/core/theme/app_typography.dart';

void main() {
  group('AppPrimitives', () {
    test('contains expected primitive colors', () {
      expect(AppPrimitives.blue500, const Color(0xFF3B82F6));
      expect(AppPrimitives.violet500, const Color(0xFF8B5CF6));
      expect(AppPrimitives.gray900, const Color(0xFF0F172A));
      expect(AppPrimitives.white1000, const Color(0xFFFFFFFF));
    });
  });

  group('AppColors', () {
    test('light semantic colors match Figma specification', () {
      const colors = AppColors.light;
      expect(colors.background.primary, const Color(0xFFFFFFFF));
      expect(colors.background.brand, const Color(0xFF3B82F6));
      expect(colors.text.primary, const Color(0xFF0F172A));
      expect(colors.border.defaultColor, const Color(0xFFE2E8F0));
      expect(colors.icon.primary, const Color(0xFF334155));
    });

    test('dark semantic colors match Figma specification', () {
      const colors = AppColors.dark;
      expect(colors.background.primary, const Color(0xFF0F172A));
      expect(colors.background.brand, const Color(0xFF3B82F6));
      expect(colors.text.primary, const Color(0xFFFFFFFF));
      expect(colors.border.defaultColor, const Color(0xFF334155));
      expect(colors.icon.primary, const Color(0xFFE2E8F0));
    });

    test('lerp transitions between light and dark', () {
      final mid = AppColors.light.lerp(AppColors.dark, 0.5);
      expect(mid.background.primary, isNotNull);
      expect(mid.text.primary, isNotNull);
    });
  });

  group('AppColorScheme', () {
    test('light colorScheme derives from seed with Figma overrides', () {
      final scheme = AppColorScheme.light;
      expect(scheme.primary, AppPrimitives.blue500);
      expect(scheme.surface, AppPrimitives.white1000);
      expect(scheme.error, AppPrimitives.red500);
      expect(scheme.surfaceTint, Colors.transparent);
      expect(scheme.surfaceContainer, isNotNull);
      expect(scheme.surfaceContainerLow, isNotNull);
      expect(scheme.surfaceContainerHigh, isNotNull);
    });

    test('dark colorScheme derives from seed with Figma overrides', () {
      final scheme = AppColorScheme.dark;
      expect(scheme.primary, AppPrimitives.blue500);
      expect(scheme.surface, AppPrimitives.gray900);
      expect(scheme.error, AppPrimitives.red500);
      expect(scheme.surfaceTint, Colors.transparent);
      expect(scheme.surfaceContainer, isNotNull);
      expect(scheme.surfaceContainerLow, isNotNull);
      expect(scheme.surfaceContainerHigh, isNotNull);
    });
  });

  group('AppSpacing', () {
    test('values match design tokens', () {
      expect(AppSpacing.s2xs, 2.0);
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.sm, 8.0);
      expect(AppSpacing.md, 12.0);
      expect(AppSpacing.lg, 16.0);
      expect(AppSpacing.xl, 20.0);
      expect(AppSpacing.s2xl, 24.0);
      expect(AppSpacing.s3xl, 32.0);
      expect(AppSpacing.s4xl, 40.0);
      expect(AppSpacing.s5xl, 48.0);
      expect(AppSpacing.s6xl, 64.0);
    });
  });

  group('AppRadius', () {
    test('values match design tokens', () {
      expect(AppRadius.none, 0.0);
      expect(AppRadius.xs, 2.0);
      expect(AppRadius.sm, 4.0);
      expect(AppRadius.md, 8.0);
      expect(AppRadius.lg, 12.0);
      expect(AppRadius.xl, 16.0);
      expect(AppRadius.s2xl, 24.0);
      expect(AppRadius.full, 9999.0);
    });
  });

  group('AppTypography', () {
    test('light typography contains 15 design system styles with Inter font family', () {
      const typo = AppTypography.light;
      expect(typo.displayLarge.fontSize, 60);
      expect(typo.displayLarge.fontWeight, FontWeight.w700);
      expect(typo.displayLarge.color, AppPrimitives.gray900);
      expect(typo.displaySmall.fontSize, 48);
      expect(typo.headingH1.fontSize, 36);
      expect(typo.headingH2.fontSize, 30);
      expect(typo.headingH3.fontSize, 24);
      expect(typo.headingH4.fontSize, 20);
      expect(typo.bodyLarge.fontSize, 18);
      expect(typo.bodyMedium.fontSize, 16);
      expect(typo.bodySmall.fontSize, 14);
      expect(typo.bodyEmphasis.fontSize, 16);
      expect(typo.bodyEmphasis.fontWeight, FontWeight.w600);
      expect(typo.bodyLink.fontSize, 16);
      expect(typo.labelLarge.fontSize, 16);
      expect(typo.labelMedium.fontSize, 14);
      expect(typo.labelSmall.fontSize, 12);
      expect(typo.caption.fontSize, 11);
    });

    test('dark typography has dark primary text color', () {
      const typo = AppTypography.dark;
      expect(typo.displayLarge.color, AppPrimitives.gray50);
      expect(typo.headingH1.color, AppPrimitives.gray50);
      expect(typo.bodyMedium.color, AppPrimitives.gray50);
    });

    test('lerp transitions between light and dark typography', () {
      final mid = AppTypography.light.lerp(AppTypography.dark, 0.5);
      expect(mid.displayLarge.fontSize, 60);
      expect(mid.headingH1.fontSize, 36);
    });

    test('toTextTheme maps styles to Material TextTheme', () {
      final textTheme = AppTypography.light.toTextTheme();
      expect(textTheme.displayLarge?.fontSize, 60);
      expect(textTheme.headlineLarge?.fontSize, 36);
      expect(textTheme.bodyMedium?.fontSize, 16);
    });
  });

  group('AppShadows', () {
    test('defines all elevation levels', () {
      expect(AppShadows.xs, isNotEmpty);
      expect(AppShadows.sm.length, 2);
      expect(AppShadows.md.length, 2);
      expect(AppShadows.lg.length, 2);
      expect(AppShadows.xl.length, 2);
      expect(AppShadows.focusRing, isNotEmpty);
    });
  });

  group('AppGradients', () {
    test('defines all gradients', () {
      expect(AppGradients.brand.colors.length, 2);
      expect(AppGradients.brandSubtle.colors.length, 2);
      expect(AppGradients.overlayScrim.colors.length, 2);
    });
  });

  group('AppTheme', () {
    test('light and dark themes have AppColors and AppTypography extensions registered', () {
      expect(AppTheme.light.extension<AppColors>(), isNotNull);
      expect(AppTheme.dark.extension<AppColors>(), isNotNull);
      expect(AppTheme.light.extension<AppTypography>(), isNotNull);
      expect(AppTheme.dark.extension<AppTypography>(), isNotNull);
    });
  });
}
