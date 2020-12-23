class User {
  String name;
  String email;
  String password;
  String token;

  Map<String, dynamic> loginToJson() => {
        'email': email,
        'password': password,
      };

  Map<String, dynamic> signUpToJson() => {
        'name': name,
        'email': email,
        'password': password,
      };

  @override
  String toString() =>
      'name = $name .... email = $email  .... password = $password .... token = $token';
}
