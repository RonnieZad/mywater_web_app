// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromotionDetails {
  final String promotionTitle;
  final String promotionShortText;
  final int promotionRewardPoints;
  final String promotionLinkUrl;
  final String promotionArtWorlUrl;
  PromotionDetails({
    required this.promotionTitle,
    required this.promotionShortText,
    required this.promotionRewardPoints,
    required this.promotionLinkUrl,
    required this.promotionArtWorlUrl,
  });

  PromotionDetails copyWith({
    String? promotionTitle,
    String? promotionShortText,
    int? promotionRewardPoints,
    String? promotionLinkUrl,
    String? promotionArtWorlUrl,
  }) {
    return PromotionDetails(
      promotionTitle: promotionTitle ?? this.promotionTitle,
      promotionShortText: promotionShortText ?? this.promotionShortText,
      promotionRewardPoints: promotionRewardPoints ?? this.promotionRewardPoints,
      promotionLinkUrl: promotionLinkUrl ?? this.promotionLinkUrl,
      promotionArtWorlUrl: promotionArtWorlUrl ?? this.promotionArtWorlUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promotionTitle': promotionTitle,
      'promotionShortText': promotionShortText,
      'promotionRewardPoints': promotionRewardPoints,
      'promotionLinkUrl': promotionLinkUrl,
      'promotionArtWorlUrl': promotionArtWorlUrl,
    };
  }

  factory PromotionDetails.fromMap(Map<String, dynamic> map) {
    return PromotionDetails(
      promotionTitle: map['promotionTitle'] as String,
      promotionShortText: map['promotionShortText'] as String,
      promotionRewardPoints: map['promotionRewardPoints'] as int,
      promotionLinkUrl: map['promotionLinkUrl'] as String,
      promotionArtWorlUrl: map['promotionArtWorlUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromotionDetails.fromJson(String source) => PromotionDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PromotionDetails(promotionTitle: $promotionTitle, promotionShortText: $promotionShortText, promotionRewardPoints: $promotionRewardPoints, promotionLinkUrl: $promotionLinkUrl, promotionArtWorlUrl: $promotionArtWorlUrl)';
  }

  @override
  bool operator ==(covariant PromotionDetails other) {
    if (identical(this, other)) return true;

    return other.promotionTitle == promotionTitle && other.promotionShortText == promotionShortText && other.promotionRewardPoints == promotionRewardPoints && other.promotionLinkUrl == promotionLinkUrl && other.promotionArtWorlUrl == promotionArtWorlUrl;
  }

  @override
  int get hashCode {
    return promotionTitle.hashCode ^ promotionShortText.hashCode ^ promotionRewardPoints.hashCode ^ promotionLinkUrl.hashCode ^ promotionArtWorlUrl.hashCode;
  }
}
