import 'package:mobileapp/features/global_components/presentation/sections/chip_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/divider_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/table_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/progress_bar_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/stepper_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/breadcrumb_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/pagination_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/accordion_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/modal_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/tooltip_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/alert_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobileapp/core/theme/providers/theme_mode_provider.dart';
import 'package:mobileapp/core/extensions/build_context_extension.dart';
import 'package:mobileapp/core/theme/app_spacing.dart';
import 'package:mobileapp/features/global_components/presentation/sections/button_group_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/button_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/fab_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/icon_button_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/input_field_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/search_field_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/select_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/checkbox_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/radio_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/switch_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/slider_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/menu_item_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/nav_bar_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/bottom_tab_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/action_sheet_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/badge_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/avatar_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/card_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/top_app_bar_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/side_nav_item_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/tab_item_section.dart';
import 'package:mobileapp/features/global_components/presentation/sections/textarea_field_section.dart';

class GlobalComponentsScreen extends ConsumerWidget {
  const GlobalComponentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final typography = context.typography;
    final currentThemeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      backgroundColor: colors.background.primary,
      appBar: AppBar(
        title: Text(
          'global_components.title'.tr(),
          style: typography.headingH3.withColor(colors.text.primary),
        ),
        backgroundColor: colors.background.secondary,
        elevation: 0,
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(Icons.brightness_6, color: colors.icon.primary),
            initialValue: currentThemeMode,
            onSelected: (mode) {
              ref.read(appThemeModeProvider.notifier).setThemeMode(mode);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text('global_components.light'.tr()),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text('global_components.dark'.tr()),
              ),
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text('global_components.system'.tr()),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.language, color: colors.icon.primary),
            onPressed: () {
              final newLocale = context.locale.languageCode == 'en'
                  ? const Locale('vi')
                  : const Locale('en');
              context.setLocale(newLocale);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          ButtonSection(),
          SizedBox(height: AppSpacing.lg),
          IconButtonSection(),
          SizedBox(height: AppSpacing.lg),
          FabSection(),
          SizedBox(height: AppSpacing.lg),
          ButtonGroupSection(),
          SizedBox(height: AppSpacing.lg),
          InputFieldSection(),
          SizedBox(height: AppSpacing.lg),
          SelectSection(),
          SizedBox(height: AppSpacing.lg),
          SearchFieldSection(),
          SizedBox(height: AppSpacing.lg),
          TextareaFieldSection(),
          SizedBox(height: AppSpacing.lg),
          CheckboxSection(),
          SizedBox(height: AppSpacing.lg),
          RadioSection(),
          SizedBox(height: AppSpacing.lg),
          SwitchSection(),
          SizedBox(height: AppSpacing.lg),
          SliderSection(),
          SizedBox(height: AppSpacing.lg),
          MenuItemSection(),
          SizedBox(height: AppSpacing.lg),
          TabItemSection(),
          SizedBox(height: AppSpacing.lg),
          NavBarSection(),
          SizedBox(height: AppSpacing.lg),
          SideNavItemSection(),
          SizedBox(height: AppSpacing.lg),
          BottomTabSection(),
          SizedBox(height: AppSpacing.lg),
          TopAppBarSection(),
          SizedBox(height: AppSpacing.lg),
          ActionSheetSection(),
          SizedBox(height: AppSpacing.lg),
          BadgeSection(),
          SizedBox(height: AppSpacing.lg),
          CardSection(),
          SizedBox(height: AppSpacing.lg),
          AvatarSection(),
          SizedBox(height: AppSpacing.lg),
          AlertSection(),
          SizedBox(height: AppSpacing.lg),
          TooltipSection(),
          SizedBox(height: AppSpacing.lg),
          ModalSection(),
          SizedBox(height: AppSpacing.lg),
          AccordionSection(),
          SizedBox(height: AppSpacing.lg),
          PaginationSection(),
          SizedBox(height: AppSpacing.lg),
          BreadcrumbSection(),
          SizedBox(height: AppSpacing.lg),
          StepperSection(),
          SizedBox(height: AppSpacing.lg),
          ProgressBarSection(),
          SizedBox(height: AppSpacing.lg),
          TableSection(),
          SizedBox(height: AppSpacing.lg),
          DividerSection(),
          SizedBox(height: AppSpacing.lg),
          ChipSection(),
        ],
      ),
    );
  }
}
