class User {
  final String id;
  final String role;
  final String email;

  User({required this.id, required this.role, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], role: json['role'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'role': role, 'email': email};
}