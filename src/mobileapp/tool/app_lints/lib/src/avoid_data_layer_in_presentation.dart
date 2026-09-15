// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/error.dart' hide LintCode;
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// Clean Architecture guard: presentation talks to domain use cases, never to
/// repositories or data sources directly. Without this rule, screens slowly
/// grow inline `ref.read(xxxRepositoryProvider).method()` calls and the use
/// case layer is skipped (the regression this harness exists to prevent).
class AvoidDataLayerInPresentation extends DartLintRule {
  const AvoidDataLayerInPresentation() : super(code: _code);

  static const _code = LintCode(
    name: 'avoid_data_layer_in_presentation',
    problemMessage:
        'Presentation must not import the data layer or repository contracts '
        'directly. Call a domain use case instead.',
    correctionMessage:
        'Move the operation into a use case under domain/use_cases and have '
        'the screen provider call that use case.',
    errorSeverity: ErrorSeverity.ERROR,
  );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final path = resolver.path;
    if (!path.contains('/lib/')) return;
    if (!path.contains('/presentation/')) return;
    if (path.endsWith('.g.dart') || path.endsWith('.freezed.dart')) return;

    void check(UriBasedDirective directive) {
      final uri = directive.uri.stringValue;
      if (uri == null) return;
      if (uri.contains('/data/') ||
          uri.contains('/data_sources/') ||
          uri.contains('/domain/repositories/')) {
        reporter.atNode(directive, _code);
      }
    }

    context.registry.addImportDirective(check);
    context.registry.addExportDirective(check);
  }
}
