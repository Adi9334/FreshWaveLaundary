class user_model {
  String name;
  String email;
  String password;
  String phone_number;
  String address;

  user_model({
    required this.name,
    required this.email,
    required this.password,
    required this.phone_number,
    required this.address,
  });

  factory user_model.fromJson(Map<String, dynamic> json) {
    return user_model(
        name: json['username'],
        email: json['email'],
        password: json['password'],
        phone_number: json['phone_number'],
        address: json['address']);
  }
}
