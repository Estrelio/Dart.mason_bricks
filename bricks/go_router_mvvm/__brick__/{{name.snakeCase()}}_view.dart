import 'package:flutter/material.dart';
{{#data}}
import 'package:{{{importRoot}}}/{{name.snakeCase()}}_view_data.dart';
{{/data}}

class {{name.pascalCase()}}View extends StatefulWidget {
const {{name.pascalCase()}}View({
super.key,
{{#data}}
required this.viewArg,
{{/data}}
});

{{#data}}
final {{name.pascalCase()}}ViewData viewArg;
{{/data}}

@override
_{{name.pascalCase()}}ViewState createState() => _{{name.pascalCase()}}ViewState();
}

class _{{name.pascalCase()}}ViewState extends State<{{name.pascalCase()}}View> {
@override
Widget build(BuildContext context) {
return const Placeholder();
}
}
