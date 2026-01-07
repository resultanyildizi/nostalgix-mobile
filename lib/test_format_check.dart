void main() {
  emit(
    State(
      option1: none(),
      option2: none(),
      isDoingCheck: true,
      extraLongArgForLength:
          'This is a very long string that will definitely push the line length over 80 characters to force a wrap by the formatter',
    ),
  );
}

void emit(State state) {}
State none() => State();

class State {
  State({
    this.option1,
    this.option2,
    this.isDoingCheck,
    this.extraLongArgForLength,
  });
  final State? option1;
  final State? option2;
  final bool? isDoingCheck;
  final String? extraLongArgForLength;
}
