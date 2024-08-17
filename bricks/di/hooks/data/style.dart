enum GenerationStyle {
  getX(
    value: 'get_x',
  ),
  getIt(
    value: 'get_it',
  );

  final String value;

  const GenerationStyle({
    required this.value,
  });

  static GenerationStyle fromString(String value) {
    return GenerationStyle.values.firstWhere(
      (e) => e.value == value,
    );
  }

  bool get isGetX => this == GenerationStyle.getX;

  bool get isGetIt => this == GenerationStyle.getIt;
}
