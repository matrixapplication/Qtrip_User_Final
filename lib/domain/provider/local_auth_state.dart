class LocalAuthState {
  ///Variables
  bool isLogin = false;
  bool loading = false;
  String? error;

  LocalAuthState();

  LocalAuthState copyWith({
    bool? isLogin,
    bool? loading,
    String? error,
  }) {
    return LocalAuthState()
      ..isLogin = isLogin ?? this.isLogin
      ..loading = loading ?? this.loading
      ..error = error ?? this.error;
  }
}

