import 'package:common/common.dart';
import 'package:mason/mason.dart';

import 'constant.dart';

void run(HookContext context) {
  context.dumpVariables();
  final String viewName = (context.vars[Constant.nameKey] as String).pascalCase;
  final bool hasData = context.vars[MvvmConstant.dataKey] as bool;

  final StringBuffer sb = StringBuffer();
  _printRouteName(
    sb: sb,
    viewName: viewName,
  );
  _printRouteRegistrationCode(
    sb: sb,
    viewName: viewName,
    hasData: hasData,
  );
  context.logger.info(sb.toString());
}

void _printRouteRegistrationCode({
  required StringBuffer sb,
  required String viewName,
  required bool hasData,
}) {
  /* Example:
  GoRoute(
    path: RoutePath.product,
    builder: (
      BuildContext context,
      GoRouterState state,
    ) {
      return ProductView(
        viewArg: _parseExtra<ProductViewData>(
          state: state,
          fromJson: (Map<String, dynamic> json) =>
              ProductViewData.fromJson(json),
        ),
      );
    },
  ),
  */
  sb.writeln();

  sb.writeln(Ansi.wrapAnsiGreenColor(
    message: 'Here is your route registration code:',
  ));
  sb.writeln();

  switch (hasData) {
    case true:
      final String pascalCaseViewName = viewName.pascalCase;
      sb.writeln("GoRoute(");
      sb.writeln("  path: RoutePath.${viewName.camelCase},");
      sb.writeln("  builder: (");
      sb.writeln("    BuildContext context,");
      sb.writeln("    GoRouterState state,");
      sb.writeln("  ) {");
      sb.writeln("  return ${pascalCaseViewName}View(");
      sb.writeln("    viewArg: _parseExtra<${pascalCaseViewName}Data>(");
      sb.writeln("      state: state,");
      sb.writeln("      fromJson: (Map<String, dynamic> json) =>");
      sb.writeln("          ${pascalCaseViewName}Data.fromJson(json),");
      sb.writeln("    ),");
      sb.writeln("  );");
      sb.writeln("},");
      sb.writeln("),");
      break;
    case false:
      sb.writeln("GoRoute(");
      sb.writeln("  path: RoutePath.${viewName.camelCase},");
      sb.writeln("  builder: (");
      sb.writeln("    BuildContext context,");
      sb.writeln("    GoRouterState state,");
      sb.writeln("  ) => const ${viewName.pascalCase}View(),");
      sb.writeln("),");
      break;
  }
}

void _printRouteName({
  required StringBuffer sb,
  required String viewName,
}) {
  sb.writeln();

  sb.writeln(Ansi.wrapAnsiGreenColor(
    message: 'Here is your route name:',
  ));
  sb.writeln();
  // Example: static const String home = '/home';
  final String camelCaseViewName = viewName.camelCase;
  sb.writeln(
      "static const String ${camelCaseViewName} = '/${camelCaseViewName}';");
}
