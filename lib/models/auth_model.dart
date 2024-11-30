// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthModel {
  final String? userId;
  final String? name;
  final String phonenumber;
  final String? location;
  final String? gender;
  final double? latitude;
  final double? longitude;
  AuthModel({
    this.userId,
    this.name,
    required this.phonenumber,
    this.location,
    this.gender,
    this.latitude,
    this.longitude,
  });

  AuthModel copyWith({
    String? userId,
    String? name,
    String? phonenumber,
    String? location,
    String? gender,
    double? latitude,
    double? longitude,
  }) {
    return AuthModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phonenumber: phonenumber ?? this.phonenumber,
      location: location ?? this.location,
      gender: gender ?? this.gender,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'phonenumber': phonenumber,
      'location': location,
      'gender': gender,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phonenumber: map['phonenumber'] as String,
      location: map['location'] != null ? map['location'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(userId: $userId, name: $name, phonenumber: $phonenumber, location: $location, gender: $gender, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.name == name && other.phonenumber == phonenumber && other.location == location && other.gender == gender && other.latitude == latitude && other.longitude == longitude;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ name.hashCode ^ phonenumber.hashCode ^ location.hashCode ^ gender.hashCode ^ latitude.hashCode ^ longitude.hashCode;
  }
}
