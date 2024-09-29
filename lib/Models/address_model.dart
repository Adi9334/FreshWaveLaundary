class address_model {
  final id;
  final full_name;
  final phone_number;
  final pincode;
  final state;
  final city;
  final street;
  final area;

  address_model({
    required this.id,
    required this.full_name,
    required this.phone_number,
    required this.pincode,
    required this.state,
    required this.city,
    required this.street,
    required this.area,
  });

  factory address_model.fromJson(Map<String, dynamic> json) {
    return address_model(
      id: json['id'],
      full_name: json['full_name'],
      phone_number: json['phone_number'],
      pincode: json['pincode'],
      state: json['state'],
      city: json['city'],
      street: json['street'],
      area: json['area'],
    );
  }
}
