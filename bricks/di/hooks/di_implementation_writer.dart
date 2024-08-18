import 'package:common/common.dart';
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
    if (implementation != null) {
      sb.writeln('/// ${implementation} implementation:');
    }
    {
      /* Example:
        GetIt.I.registerSingleton<AppointmentRepositoryService>(
          MockAppointmentRepositoryService(),
        );
      */
      sb.writeln(Ansi.wrapAnsiGreenColor(message: 'Register Singleton:'));
      sb.writeln();
      sb.writeln(
        'GetIt.I.registerSingleton<${serviceName}>(',
      );
      sb.writeln(
        '  ${implementation?.pascalCase ?? ''}${serviceName}(),',
      );
      sb.writeln(');');
    }
    sb.writeln('---------------------------------------------------------');
    {
      /* Example:
        GetIt.I.registerLazySingleton<AppointmentRepositoryService>(
          () => MockAppointmentRepositoryService(),
        );
      */
      sb.writeln(Ansi.wrapAnsiGreenColor(message: 'Register Lazy Singleton:'));
      sb.writeln();
      sb.writeln(
        'GetIt.I.registerLazySingleton<${serviceName}>(',
      );
      sb.writeln(
        '  () => ${implementation?.pascalCase ?? ''}${serviceName}(),',
      );
      sb.writeln(');');
    }
    sb.writeln('---------------------------------------------------------');
    {
      /* Example:
        GetIt.I.registerFactory<AppointmentRepositoryService>(
          () => MockAppointmentRepositoryService(),
        );
      */
      sb.writeln(Ansi.wrapAnsiGreenColor(message: 'Register factory:'));
      sb.writeln();
      sb.writeln(
        'GetIt.I.registerFactory<${serviceName}>(',
      );
      sb.writeln(
        '  () => ${implementation?.pascalCase ?? ''}${serviceName}(),',
      );
      sb.writeln(');');
    }
    sb.writeln();
  }
}
