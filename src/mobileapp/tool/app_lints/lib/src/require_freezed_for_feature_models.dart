// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Feature entities and presentation states must be generated with Freezed so
/// equality, `copyWith` and state unions stay consistent. Hand-written
/// `copyWith`/`==` drift silently and caused several stale-state bugs.
class RequireFreezedForFeatureModels extends DartLintRule {
  const RequireFreezedForFeatureModels() : super(code: _code);

  static const _code = LintCode(
    name: 'require_freezed_for_feature_models',
    problemMessage:
        'Entities and presentation state classes must be annotated with '
        '@freezed and generated (make gen-code).',
    correctionMessage:
        'Annotate the class with @freezed (or model it as an enum/value object) '
        'and run make gen-code.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  static bool _isTarget(String path) {
    if (!path.contains('/lib/')) return false;
    if (path.endsWith('.freezed.dart') || path.endsWith('.g.dart')) {
      return false;
    }
    return path.contains('/domain/entities/') ||
        path.contains('/presentation/states/');
  }

  static bool _hasFreezed(NodeList<Annotation> metadata) {
    for (final annotation in metadata) {
      if (annotation.name.name == 'freezed') return true;
    }
    return false;
  }

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    if (!_isTarget(resolver.path)) return;

    context.registry.addClassDeclaration((node) {
      if (_hasFreezed(node.metadata)) return;
      reporter.atNode(node, _code);
    });
  }
}
