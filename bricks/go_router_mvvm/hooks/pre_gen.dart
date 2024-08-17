import 'dart:io';

import 'package:common/common.dart';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final Directory currentDirectory = Directory.current;

  context.replacePlaceholderNameWithDirectoryNameIfNeeded(
    currentDirectory: currentDirectory,
  );
  context.dumpVariables();
  context.vars['importRoot'] =
      ImportPathResolver.getImportPath(currentDirectory: currentDirectory);
}
