enum AppFonts {
  playfair._(
      'Playfair', 'assets/fonts/PlayfairDisplay/PlayfairDisplay-Regular.ttf'),
  lato._('Lato', 'assets/fonts/Lato/Lato-Regular.ttf'),
  ;

  const AppFonts._(this.family, this.path);
  final String family;
  final String path;
}
