class UserModel {
  String email;
  String password;

  UserModel(this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'email': email, 'password': password};
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(map['email'], map['password']);
  }
  @override
  String toString() {
    return "id:id-email:$email-password:$password";
  }
}
