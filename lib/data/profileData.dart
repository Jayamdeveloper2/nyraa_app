// lib/data/profileData.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  final String email;
  final String name;
  final String phone;
  final String joinDate;

  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.joinDate,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'name': name,
    'phone': phone,
    'joinDate': joinDate,
  };

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    email: json['email'],
    name: json['name'],
    phone: json['phone'],
    joinDate: json['joinDate'],
  );
}

final dummyUser = UserData(
  email: 'user@example.com',
  name: 'John Doe',
  phone: '(555) 123-4567',
  joinDate: 'June 2023',
);

Future<UserData> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('userData');
  if (userDataString != null) {
    return UserData.fromJson(jsonDecode(userDataString));
  }
  return dummyUser;
}

Future<void> updateUserData(UserData newUserData) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userData', jsonEncode(newUserData.toJson()));
}

Future<void> clearUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userData');
  await prefs.setBool('isLoggedIn', false);
}