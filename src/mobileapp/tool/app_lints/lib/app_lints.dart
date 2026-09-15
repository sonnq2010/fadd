import 'package:app_lints/src/avoid_data_layer_in_presentation.dart';
import 'package:app_lints/src/require_freezed_for_feature_models.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'src/avoid_direct_theme_usage.dart';

PluginBase createPlugin() => _AppLintsPlugin();

class _AppLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [
    AvoidDirectThemeColorScheme(),
    AvoidDirectThemeTextTheme(),
    AvoidDataLayerInPresentation(),
    RequireFreezedForFeatureModels(),
  ];
}
