// ignore_for_file: deprecated_member_use

import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidDirectThemeColorScheme extends DartLintRule {
  const AvoidDirectThemeColorScheme() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_theme_color_scheme',
    problemMessage:
        'Avoid using Theme.of(context).colorScheme directly. Use context.colors from the Design System instead.',
    correctionMessage:
        'Replace with context.colors to maintain design system consistency.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  static const _themeDataChecker = TypeChecker.fromName(
    'ThemeData',
    packageName: 'flutter',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (resolver.path.contains('/lib/core/theme/')) {
      return;
    }

    context.registry.addPropertyAccess((node) {
      if (node.propertyName.name != 'colorScheme') return;
      final targetType = node.realTarget.staticType;
      if (targetType != null &&
          _themeDataChecker.isAssignableFromType(targetType)) {
        reporter.atNode(node, code);
      }
    });

    context.registry.addPrefixedIdentifier((node) {
      if (node.identifier.name != 'colorScheme') return;
      final prefixType = node.prefix.staticType;
      if (prefixType != null &&
          _themeDataChecker.isAssignableFromType(prefixType)) {
        reporter.atNode(node, code);
      }
    });
  }
}

class AvoidDirectThemeTextTheme extends DartLintRule {
  const AvoidDirectThemeTextTheme() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_direct_theme_text_theme',
    problemMessage:
        'Avoid using Theme.of(context).textTheme directly. Use context.typography from the Design System instead.',
    correctionMessage:
        'Replace with context.typography to maintain design system consistency.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  static const _themeDataChecker = TypeChecker.fromName(
    'ThemeData',
    packageName: 'flutter',
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (resolver.path.contains('/lib/core/theme/')) {
      return;
    }

    context.registry.addPropertyAccess((node) {
      if (node.propertyName.name != 'textTheme') return;
      final targetType = node.realTarget.staticType;
      if (targetType != null &&
          _themeDataChecker.isAssignableFromType(targetType)) {
        reporter.atNode(node, code);
      }
    });

    context.registry.addPrefixedIdentifier((node) {
      if (node.identifier.name != 'textTheme') return;
      final prefixType = node.prefix.staticType;
      if (prefixType != null &&
          _themeDataChecker.isAssignableFromType(prefixType)) {
        reporter.atNode(node, code);
      }
    });
  }
}
