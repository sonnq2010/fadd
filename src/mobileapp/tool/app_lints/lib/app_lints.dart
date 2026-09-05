import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'src/avoid_direct_theme_usage.dart';

PluginBase createPlugin() => _AppLintsPlugin();

class _AppLintsPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
        const AvoidDirectThemeColorScheme(),
        const AvoidDirectThemeTextTheme(),
      ];
}
