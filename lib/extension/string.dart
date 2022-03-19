extension StringX on String {
  bool get isABackgroundIntent => this == 'next' || this == 'previous';
}
