import 'package:common/common.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.dumpVariables();
  final String viewName = (context.vars[Constant.nameKey] as String).pascalCase;

  final StringBuffer sb = StringBuffer();
  _printRouteName(
    sb: sb,
    viewName: viewName,
  );
  _printRouteRegistrationCode(
    sb: sb,
    viewName: viewName,
  );
  context.logger.info(sb.toString());
}

void _printRouteRegistrationCode({
  required StringBuffer sb,
  required String viewName,
}) {
  /* Example:
    GoRoute(
      path: RouteName.product,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return GoRouterMvvm<ProductViewModel, ProductViewModelData>(
          viewArg: _parseState<ProductViewModelData>(
            state: state,
            fromJson: (Map<String, dynamic> json) =>
                ProductViewModelData.fromJson(json),
          ),
          vmGetter: () {
            GetIt.I.pushNewScope();
            final ProductViewModel vm = ProductViewModel();
            GetIt.I.registerSingleton(vm);
            return vm;
          },
          onDisposed: () {
            GetIt.I.popScope();
          },
          child: const ProductView(),
        );
      },
    ),
  */
  sb.writeln();

  sb.writeln(Ansi.wrapAnsiGreenColor(
    message: 'Here is your route registration code:',
  ));
  sb.writeln();

  final String pascalCaseViewName = '${viewName.pascalCase}View';
  final String pascalCaseViewModelName = '${pascalCaseViewName}Model';
  final String pascalCaseViewModelDataName = '${pascalCaseViewName}ModelData';
  sb.writeln("GoRoute(");
  sb.writeln("  path: RoutePath.${viewName.camelCase},");
  sb.writeln("  builder: (");
  sb.writeln("    BuildContext context,");
  sb.writeln("    GoRouterState state,");
  sb.writeln("  ) {");
  sb.writeln(
      "  return GoRouterMvvm<${pascalCaseViewModelName}, ${pascalCaseViewModelDataName}>(");
  sb.writeln("    viewArg: _parseState<${pascalCaseViewModelDataName}>(");
  sb.writeln("      state: state,");
  sb.writeln("      fromJson: (Map<String, dynamic> json) =>");
  sb.writeln("          ${pascalCaseViewModelDataName}.fromJson(json),");
  sb.writeln("    ),");
  sb.writeln("    vmGetter: () {");
  sb.writeln("      GetIt.I.pushNewScope();");
  sb.writeln(
      "      final ${pascalCaseViewModelName} vm = ${pascalCaseViewModelName}();");
  sb.writeln("      GetIt.I.registerSingleton(vm);");
  sb.writeln("      return vm;");
  sb.writeln("    },");
  sb.writeln("    onDisposed: () {");
  sb.writeln("      GetIt.I.popScope();");
  sb.writeln("    },");
  sb.writeln("    child: const ${pascalCaseViewName}(),");
  sb.writeln("  );");
  sb.writeln("},");
  sb.writeln("),");
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
