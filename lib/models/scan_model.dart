// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mywater_web_app/models/models.dart';

class ScanModel {
  final String scanCodeId;
  final String? userId;
  final double? latitude;
  final double? longitude;
  final String? scanTime;
  final CompanyDetails? companyDetails;
  final PromotionDetails? promotionDetails;
  ScanModel({
    required this.scanCodeId,
    this.userId,
    this.latitude,
    this.longitude,
    this.scanTime,
    this.companyDetails,
    this.promotionDetails,
  });

  ScanModel copyWith({
    String? scanCodeId,
    String? userId,
    double? latitude,
    double? longitude,
    String? scanTime,
    CompanyDetails? companyDetails,
    PromotionDetails? promotionDetails,
  }) {
    return ScanModel(
      scanCodeId: scanCodeId ?? this.scanCodeId,
      userId: userId ?? this.userId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      scanTime: scanTime ?? this.scanTime,
      companyDetails: companyDetails ?? this.companyDetails,
      promotionDetails: promotionDetails ?? this.promotionDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'scanCodeId': scanCodeId,
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'scanTime': scanTime,
      'companyDetails': companyDetails?.toMap(),
      'promotionDetails': promotionDetails?.toMap(),
    };
  }

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      scanCodeId: map['scanCodeId'] as String,
      userId: map['userId'] != null ? map['userId'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      scanTime: map['scanTime'] != null ? map['scanTime'] as String : null,
      companyDetails: map['companyDetails'] != null ? CompanyDetails.fromMap(map['companyDetails'] as Map<String, dynamic>) : null,
      promotionDetails: map['promotionDetails'] != null ? PromotionDetails.fromMap(map['promotionDetails'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanModel.fromJson(String source) => ScanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScanModel(scanCodeId: $scanCodeId, userId: $userId, latitude: $latitude, longitude: $longitude, scanTime: $scanTime, companyDetails: $companyDetails, promotionDetails: $promotionDetails)';
  }

  @override
  bool operator ==(covariant ScanModel other) {
    if (identical(this, other)) return true;

    return other.scanCodeId == scanCodeId && other.userId == userId && other.latitude == latitude && other.longitude == longitude && other.scanTime == scanTime && other.companyDetails == companyDetails && other.promotionDetails == promotionDetails;
  }

  @override
  int get hashCode {
    return scanCodeId.hashCode ^ userId.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ scanTime.hashCode ^ companyDetails.hashCode ^ promotionDetails.hashCode;
  }
}
