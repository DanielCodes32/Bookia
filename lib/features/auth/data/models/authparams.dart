class Authparams {
  final String? email;
  final String? password;
  final String? name;
  final String? passwordconfirmation;

  Authparams({this.email, this.password, this.name, this.passwordconfirmation});
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordconfirmation,
    };
  }
}
