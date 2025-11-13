import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final DateTime? createdAt;

  const UserModel({required this.id, required this.name, required this.email, this.phone, this.avatar, this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone, 'avatar': avatar, 'createdAt': createdAt?.toIso8601String()};
  }

  UserModel copyWith({String? id, String? name, String? email, String? phone, String? avatar, DateTime? createdAt}) {
    return UserModel(id: id ?? this.id, name: name ?? this.name, email: email ?? this.email, phone: phone ?? this.phone, avatar: avatar ?? this.avatar, createdAt: createdAt ?? this.createdAt);
  }

  @override
  List<Object?> get props => [id, name, email, phone, avatar, createdAt];
}
