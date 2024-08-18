/*
 *
 * Copyright (C) 2023 taboosun
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * /
 *
 *
 */

import 'package:common/common.dart';
import 'package:mason/mason.dart';

import 'constant.dart';
import 'data/style.dart';
import 'di_implementation_writer.dart';

void run(HookContext context) {
  context.dumpVariables();

  final String serviceName =
      '${(context.vars[DiConstant.nameKey] as String).pascalCase}${(context.vars[DiConstant.suffixKey] as String).pascalCase}';
  final List<String> implementations =
      (context.vars[DiConstant.implementationsKey] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>()
              .map(
                (Map<String, dynamic> entry) =>
                    entry[DiConstant.implementationsKeyKey] as String,
              )
              .toList() ??
          <String>[];

  final StringBuffer sb = StringBuffer();
  sb.writeln(
    'You may copy on of the following codes to your service locator file:',
  );

  void writeBindingCode() {
    const String styleKey = DiConstant.styleKey;
    final String style = context.vars[styleKey];
    final GenerationStyle generationStyle = GenerationStyle.fromString(style);
    final DiImplementationWriter diImplementationWriter =
        (switch (generationStyle) {
      GenerationStyle.getX => GetXDiImplementationWriter(
          sb: sb,
          serviceName: serviceName,
        ),
      GenerationStyle.getIt => GetItDiImplementationWriter(
          sb: sb,
          serviceName: serviceName,
        ),
    });
    if (implementations.isEmpty) {
      sb.writeln();
      diImplementationWriter.write(
        implementation: null,
      );
    }
    for (final String implementation in implementations) {
      diImplementationWriter.write(
        implementation: implementation,
      );
    }
  }

  writeBindingCode();
  context.logger.info(sb.toString());
}
