# Global Components Implementation Progress

## Summary

- Source: `GLOBAL-COMPONENTS.md` & Figma file `SaROK3qzrkFcwV2qBmXG34`
- Total Components: 33
- Completed: 33 / 33 (All 33 Components Complete)
- Status: All components implemented, mounted in showcase screens, covered by unit tests, and verified via `make verify` in both `src/mobileapp` and `src/webapp`.

## Status Matrix

| #   | Component              | Figma Node | Mobile Widget                                                     | Web Component                                                       | Showcase Section | Unit Tests | Verification                   | Status    |
| --- | ---------------------- | ---------- | ----------------------------------------------------------------- | ------------------------------------------------------------------- | ---------------- | ---------- | ------------------------------ | --------- |
| 1   | Button                 | `145:6373` | `AppButton` (`buttons.dart`)                                      | `Button` (`button.tsx`)                                             | Done             | Done       | Passed (`make verify` in both) | Completed |
| 2   | Icon Button            | `145:6374` | `AppIconButton` (`buttons.dart`)                                  | `IconButton` (`icon-button.tsx`)                                    | Done             | Done       | Passed (`make verify` in both) | Completed |
| 3   | FAB                    | `145:6377` | `AppFab` (`app_fab.dart`)                                         | `Fab` (`fab.tsx`)                                                   | Done             | Done       | Passed (`make verify` in both) | Completed |
| 4   | Button Group           | `145:6385` | `AppButtonGroup` (`app_button_group.dart`)                        | `ButtonGroup` (`button-group.tsx`)                                  | Done             | Done       | Passed (`make verify` in both) | Completed |
| 5   | Input Field            | `145:6383` | `AppInputField` (`app_input_field.dart`)                          | `InputField` (`input-field.tsx`)                                    | Done             | Done       | Passed (`make verify` in both) | Completed |
| 6   | Select                 | `145:6378` | `AppSelect` (`app_select.dart`)                                   | `SelectField` (`select-field.tsx`)                                  | Done             | Done       | Passed (`make verify` in both) | Completed |
| 7   | Search Field           | `145:6380` | `AppSearchField` (`app_search_field.dart`)                        | `SearchField` (`search-field.tsx`)                                  | Done             | Done       | Passed (`make verify` in both) | Completed |
| 8   | Textarea Field         | `145:6376` | `AppTextareaField` (`app_textarea_field.dart`)                    | `TextareaField` (`textarea-field.tsx`)                              | Done             | Done       | Passed (`make verify` in both) | Completed |
| 9   | Checkbox               | `145:6381` | `AppCheckbox` (`app_checkbox.dart`)                               | `Checkbox` (`checkbox.tsx`)                                         | Done             | Done       | Passed (`make verify` in both) | Completed |
| 10  | Radio                  | `145:6375` | `AppRadio` (`app_radio.dart`)                                     | `RadioGroup` (`radio-group.tsx`)                                    | Done             | Done       | Passed (`make verify` in both) | Completed |
| 11  | Switch                 | `145:6357` | `AppSwitch` (`app_switch.dart`)                                   | `Switch` (`switch.tsx`)                                             | Done             | Done       | Passed (`make verify` in both) | Completed |
| 12  | Slider                 | `145:6386` | `AppSlider` (`app_slider.dart`)                                   | `Slider` (`slider.tsx`)                                             | Done             | Done       | Unit & E2E Passed              | Completed |
| 13  | Menu Item              | `145:6390` | `AppMenuItem` (`app_menu_item.dart`)                              | `MenuItem` (`menu-item.tsx`)                                        | Done             | Done       | Unit Passed                    | Completed |
| 14  | Tab Item               | `145:6387` | `AppTabItem`, `AppTabs` (`app_tab_item.dart`)                     | `TabItem`, `TabsNav` (`tab-item.tsx`)                               | Done             | Done       | Targeted Unit Passed           | Completed |
| 15  | Nav Bar                | `145:6384` | `AppNavBar` (`app_nav_bar.dart`)                                  | `NavBar` (`nav-bar.tsx`)                                            | Done             | Done       | Targeted Unit Passed           | Completed |
| 16  | Side Nav Item          | `145:6388` | `AppSideNavItem` (`app_side_nav_item.dart`)                       | `SideNavItem` (`side-nav-item.tsx`)                                 | Done             | Done       | Targeted Unit Passed           | Completed |
| 17  | Mobile Bottom Tab Item | `145:6389` | `AppBottomTabItem`, `AppBottomTabBar` (`app_bottom_tab_bar.dart`) | `MobileBottomTabItem`, `MobileBottomTabBar` (`bottom-tab-item.tsx`) | Done             | Done       | Targeted Unit Passed           | Completed |
| 18  | Mobile Top App Bar     | `145:6379` | `AppTopBar` (`app_top_bar.dart`)                                  | `MobileTopAppBar` (`mobile-top-app-bar.tsx`)                        | Done             | Done       | Targeted Unit Passed           | Completed |
| 19  | Mobile Action Sheet    | `145:6382` | `AppActionSheet` (`app_action_sheet.dart`)                        | `MobileActionSheet` (`mobile-action-sheet.tsx`)                     | Done             | Done       | Targeted Unit Passed           | Completed |
| 20  | Badge                  | `159:578`  | `AppBadge` (`app_badge.dart`)                                     | `Badge` (`badge.tsx`)                                               | Done             | Done       | Targeted Unit Passed           | Completed |
| 21  | Card                   | `159:626`  | `AppCard` (`app_card.dart`)                                       | `Card` (`card.tsx`)                                                 | Done             | Done       | Targeted Unit Passed           | Completed |
| 22  | Avatar                 | `163:585`  | `AppAvatar` (`app_avatar.dart`)                                   | `Avatar` (`avatar.tsx`)                                             | Done             | Done       | Targeted Unit Passed           | Completed |
| 23  | Alert                  | `163:642`  | `AppAlert` (`app_alert.dart`)                                     | `Alert` (`alert.tsx`)                                               | Done             | Done       | Targeted Unit Passed           | Completed |
| 24  | Tooltip                | `163:703`  | `AppTooltip` / `AppTooltipBubble` (`app_tooltip.dart`)            | `Tooltip` / `TooltipBubble` (`tooltip.tsx`)                         | Done             | Done       | Targeted Unit Passed           | Completed |
| 25  | Modal                  | `163:760`  | `AppModalCard` / `showAppModal` (`app_modal.dart`)                | `ModalCard` / `Modal` (`modal.tsx`)                                 | Done             | Done       | Targeted Unit Passed           | Completed |
| 26  | Accordion              | `167:618`  | `AppAccordionItem` (`app_accordion.dart`)                         | `Accordion` / `AccordionItem` (`accordion.tsx`)                     | Done             | Done       | Targeted Unit Passed           | Completed |
| 27  | Pagination             | `167:651`  | `AppPagination` / `AppPaginationItem` (`app_pagination.dart`)     | `Pagination` / `PaginationLink` (`pagination.tsx`)                  | Done             | Done       | Targeted Unit Passed           | Completed |
| 28  | Breadcrumb             | `172:565`  | `AppBreadcrumb` / `AppBreadcrumbItem` (`app_breadcrumb.dart`)     | `Breadcrumb` / `BreadcrumbLink` (`breadcrumb.tsx`)                  | Done             | Done       | Targeted Unit Passed           | Completed |
| 29  | Stepper                | `175:603`  | `AppStepper` / `AppStepperItem` (`app_stepper.dart`)              | `Stepper` / `StepperItem` (`stepper.tsx`)                           | Done             | Done       | Targeted Unit Passed           | Completed |
| 30  | Progress Bar           | `179:591`  | `AppProgressBar` (`app_progress_bar.dart`)                        | `ProgressBar` (`progress.tsx`)                                      | Done             | Done       | Targeted Unit Passed           | Completed |
| 31  | Table                  | `183:594`  | `AppTable` (`app_table.dart`)                                     | `Table` (`table.tsx`)                                               | Done             | Done       | Targeted Unit Passed           | Completed |
| 32  | Divider                | `193:647`  | `AppDivider` (`app_divider.dart`)                                 | `Divider` (`divider.tsx`)                                           | Done             | Done       | Targeted Unit Passed           | Completed |
| 33  | Chip                   | `193:674`  | `AppChip` (`app_chip.dart`)                                       | `Chip` (`chip.tsx`)                                                 | Done             | Done       | Targeted Unit Passed           | Completed |

## 2026-09-08 Figma Revision Sync

- Baseline: local commit `8993037`.
- Synchronized on React/web and Flutter/mobile:
  - Input Field `145:6383`
  - Search Field `145:6380`
  - Select `145:6378`
  - Textarea Field `145:6376`
  - Checkbox `145:6381`
  - Switch `145:6357`
  - Menu Item `145:6390`
  - Side Nav Item `145:6388`
  - Mobile Bottom Tab Item `145:6389`
- Revised contracts:
  - Inputs use an 8px radius, semantic focus border, Body Small at Small/Medium, and Body Medium at Large.
  - Textarea uses Body Small, an 8px radius, a 96px minimum height, and an unclipped vertical resize affordance on web.
  - Checkbox, Switch, Menu Item, and Side Nav Item now use the revised semantic hover states; disabled and selected precedence remain intact.
  - Menu Item keeps the selected checkmark before its label and preserves the existing destructive API.
  - Bottom Tab uses Label Medium, a 67.5px standalone width, a 12px bar gap, and 16/8/24px bar padding; long labels truncate instead of overlapping.
- Validation:
  - Focused web unit tests: 9 files, 30 tests passed.
  - Focused web Playwright suite: 2 tests passed.
  - Focused Flutter widget tests: 47 tests passed.
  - `make -C src/webapp verify`: passed.
  - `make -C src/mobileapp verify`: passed (126 tests).
  - Web showcase inspected in light and dark themes against the live Figma nodes.
  - Flutter production showcase launch reached only the Splash Screen with non-secret placeholder configuration; visual inspection of the component screen was not possible without a configured startup session.
  - Repository-root `make verify`: backend, web, and mobile passed; infrastructure verification was blocked because the local Docker daemon was not running for TFLint.
