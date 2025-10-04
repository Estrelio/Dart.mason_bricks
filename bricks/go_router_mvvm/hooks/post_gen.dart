import 'package:common/common.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.dumpVariables();
  final String viewName = (context.vars[Constant.nameKey] as String).pascalCase;
  final String routeClassName =
      context.vars[Constant.routeClassNameKey] as String;

  final StringBuffer sb = StringBuffer();
  _printRouteName(
    sb: sb,
    viewName: viewName,
  );
  _printRouteRegistrationCode(
    sb: sb,
    viewName: viewName,
    routeClassName: routeClassName,
  );
  context.logger.info(sb.toString());
}

void _printRouteRegistrationCode({
  required StringBuffer sb,
  required String viewName,
  required String routeClassName,
}) {
  /* Example:
    GoRoute(
      path: RoutePath.endpointSwitcher,
      parentNavigatorKey:
          registerName ? _navigationService.rootNavigatorKey : null,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return GoRouterMvvm<EndpointSwitcherViewModel,
            EndpointSwitcherViewModelData>(
          viewArg: parseState<EndpointSwitcherViewModel, EndpointSwitcherViewModelData>(
            context: context,
            state: state,
            fromJson: (Map<String, dynamic> json) =>
                EndpointSwitcherViewModelData.fromJson(json),
          ),
          vmGetter: () {
            return generateViewModel(
              vmName: 'DiscoverViewModel',
              vmBuilder: () => DiscoverViewModel(),
            );
          },
          onDisposed: (String scopeName) {
            GetIt.I.dropScope(scopeName);
          },
          child: const EndpointSwitcherView(),
        );
      },
    )
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
  sb.writeln("  path: ${routeClassName}.${viewName.camelCase},");
  sb.writeln("  builder: (");
  sb.writeln("    BuildContext context,");
  sb.writeln("    GoRouterState state,");
  sb.writeln("  ) {");
  sb.writeln(
      "  return GoRouterMvvm<${pascalCaseViewModelName}, ${pascalCaseViewModelDataName}>(");
  sb.writeln(
      "    viewArg: parseState<${pascalCaseViewModelName}, ${pascalCaseViewModelDataName}>(");
  sb.writeln("      context: context,");
  sb.writeln("      state: state,");
  sb.writeln("      fromJson: (Map<String, dynamic> json) =>");
  sb.writeln("          ${pascalCaseViewModelDataName}.fromJson(json),");
  sb.writeln("    ),");
  sb.writeln("    vmGetter: () {");
  sb.writeln("      return generateViewModel(");
  sb.writeln("        vmName: '${pascalCaseViewModelName}',");
  sb.writeln("        vmBuilder: () => ${pascalCaseViewModelName}(),");
  sb.writeln("      );");
  sb.writeln("    },");
  sb.writeln("    onDisposed: (String scopeName) {");
  sb.writeln("      GetIt.I.dropScope(scopeName);");
  sb.writeln("    },");
  sb.writeln("    child: const ${pascalCaseViewName}(),");
  sb.writeln("  );");
  sb.writeln("},");
  sb.writeln(")");
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
      "static const String ${camelCaseViewName} = '${camelCaseViewName}';");
}
