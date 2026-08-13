class UserModel {
  final String name;
  final String email;
  final String address;

  const UserModel({
    required this.name,
    required this.email,
    required this.address,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? address,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }
}