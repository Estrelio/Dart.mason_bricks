import 'package:mason/mason.dart';

sealed class DiImplementationWriter {
  final StringBuffer sb;
  final String serviceName;

  DiImplementationWriter({
    required this.sb,
    required this.serviceName,
  });

  void write({
    required String? implementation,
  });
}

class GetXDiImplementationWriter extends DiImplementationWriter {
  GetXDiImplementationWriter({
    required super.sb,
    required super.serviceName,
  });

  @override
  void write({
    required String? implementation,
  }) {
    /* Example:
  Get.lazyPut<AppointmentRepositoryService>(
    () => MockAppointmentRepositoryService(),
  );
  */
    if (implementation != null) {
      sb.writeln('/// ${implementation} implementation:');
    }
    sb.writeln(
      'Get.lazyPut<${serviceName}>(',
    );
    sb.writeln(
      '\t() => ${implementation?.pascalCase ?? ''}${serviceName}(),',
    );
    sb.writeln(');');
    sb.writeln();
  }
}

class GetItDiImplementationWriter extends DiImplementationWriter {
  GetItDiImplementationWriter({
    required super.sb,
    required super.serviceName,
  });

  @override
  void write({
    required String? implementation,
  }) {
    /* Example:
    GetIt.I.registerLazySingleton<AppointmentRepositoryService>(
      () => MockAppointmentRepositoryService(),
    );
  */
    if (implementation != null) {
      sb.writeln('/// ${implementation} implementation:');
    }
    sb.writeln(
      'Get.registerLazySingleton<${serviceName}>(',
    );
    sb.writeln(
      '\t() => ${implementation?.pascalCase ?? ''}${serviceName}(),',
    );
    sb.writeln(');');
    sb.writeln();
  }
}
