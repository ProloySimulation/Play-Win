class Profile {
  bool success;
  Data data;

  Profile({required this.success, required this.data});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int id;
  String name;
  String number;
  String balance;
  String image;
  String email;
  String createdAt;
  String updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.number,
    required this.balance,
    required this.image,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      balance: json['balance'],
      image: json['image'],
      email: json['email'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}