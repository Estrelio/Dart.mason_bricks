class Ansi {
  const Ansi._();

  static String wrapAnsiGreenColor({
    required String message,
  }) {
    return '\x1B[32m$message\x1B[0m';
  }
}
