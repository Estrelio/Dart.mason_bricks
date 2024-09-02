import 'package:common/common.dart';
import 'package:mason/mason.dart';
import 'package:uuid/uuid.dart';

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
      name: registerName ? RouteName.endpointSwitcher : null,
      path: RouteName.endpointSwitcher,
      parentNavigatorKey:
          registerName ? _navigationService.rootNavigatorKey : null,
      builder: (
        BuildContext context,
        GoRouterState state,
      ) {
        return GoRouterMvvm<EndpointSwitcherViewModel,
            EndpointSwitcherViewModelData>(
          viewArg: _parseState<EndpointSwitcherViewModelData>(
            state: state,
            fromJson: (Map<String, dynamic> json) =>
                EndpointSwitcherViewModelData.fromJson(json),
          ),
          vmGetter: () {
            const String scopeName =
                'EndpointSwitcherViewModel:0191b33e-af0b-78a2-a0ff-3cec9ab08530';
            GetIt.I.pushNewScope(scopeName: scopeName);
            final EndpointSwitcherViewModel vm =
                EndpointSwitcherViewModel();
            GetIt.I.registerSingleton(vm);
            return (vm, scopeName);
          },
          onDisposed: (String scopeName) {
            GetIt.I.dropScope(scopeName);
          },
          child: const EndpointSwitcherView(),
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
  final String vmUuid = Uuid().v7();
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
  sb.writeln(
      "      const String scopeName = '${pascalCaseViewModelName}:${vmUuid}';");
  sb.writeln("      GetIt.I.pushNewScope(scopeName: scopeName);");
  sb.writeln(
      "      final ${pascalCaseViewModelName} vm = ${pascalCaseViewModelName}();");
  sb.writeln("      GetIt.I.registerSingleton(vm);");
  sb.writeln("      return (vm, scopeName);");
  sb.writeln("    },");
  sb.writeln("    onDisposed: (String scopeName) {");
  sb.writeln("      GetIt.I.dropScope(scopeName);");
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
