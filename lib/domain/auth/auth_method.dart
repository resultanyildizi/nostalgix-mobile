enum AuthMethod {
  anonymous('anonymous'),
  google('google'),
  apple('apple'),
  ;

  const AuthMethod(this.key);
  factory AuthMethod.fromKey(String key) {
    return values.firstWhere((a) => a.key == key, orElse: () => anonymous);
  }
  final String key;
}
