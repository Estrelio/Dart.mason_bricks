import 'package:meta/meta.dart';

@immutable
class {{name.pascalCase()}}ViewModelData {
const {{name.pascalCase()}}ViewModelData();

factory {{name.pascalCase()}}ViewModelData.fromJson(Map<String, dynamic> _) {
return const {{name.pascalCase()}}ViewModelData();
}

Map<String, dynamic> toJson() {
return <String, dynamic>{};
}
}