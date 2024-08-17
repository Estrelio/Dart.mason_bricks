{{#isGetIt}}
{{> get_it.dart }}
{{/isGetIt}}
{{#isGetX}}
{{> get_x.dart }}
{{/isGetX}}

{{#hasImplementations}}abstract {{/hasImplementations}}class {{name.pascalCase()}}{{suffix.pascalCase()}} {{inheritSnippet}} {


}
