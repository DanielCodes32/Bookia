class Forgetparams {
  final String? email;
  final String? password;
  final String? otp;
  final String? passwordconfirmation;

  Forgetparams({this.email, this.password, this.otp, this.passwordconfirmation});
  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "email": email,
      "password": password,
      "password_confirmation": passwordconfirmation,
    };
  }
}