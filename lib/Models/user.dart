import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String gender;
  final String phone;
  final String? photoUrl;
  final String? whatsapp;
  final String? filmDept;
  final String? role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.gender,
    required this.phone,
    this.photoUrl,
    required this.whatsapp,
    required this.filmDept,
    this.role,
    required this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['userName'],
      email: map['email'],
      gender: map['gender'] ?? "",
      phone: map['phone'] ?? "",
      photoUrl: map['profileImage'],
      whatsapp: map['whatsapp'],
      filmDept: map['filmDept'],
      role: map['role'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userName': username,
      'gender': gender,
      'phone': phone,
      'profileImage': photoUrl,
      'whatsapp': whatsapp,
      'filmDept': filmDept,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }
}
