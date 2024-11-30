// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CompanyDetails {
  final String companyName;
  final String companyShortDescription;
  final String companyLogo;
  final String companyEmail;
  final String companyPhone;
  final String companyWebsite;
  CompanyDetails({
    required this.companyName,
    required this.companyShortDescription,
    required this.companyLogo,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyWebsite,
  });

  CompanyDetails copyWith({
    String? companyName,
    String? companyShortDescription,
    String? companyLogo,
    String? companyEmail,
    String? companyPhone,
    String? companyWebsite,
  }) {
    return CompanyDetails(
      companyName: companyName ?? this.companyName,
      companyShortDescription: companyShortDescription ?? this.companyShortDescription,
      companyLogo: companyLogo ?? this.companyLogo,
      companyEmail: companyEmail ?? this.companyEmail,
      companyPhone: companyPhone ?? this.companyPhone,
      companyWebsite: companyWebsite ?? this.companyWebsite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyName': companyName,
      'companyShortDescription': companyShortDescription,
      'companyLogo': companyLogo,
      'companyEmail': companyEmail,
      'companyPhone': companyPhone,
      'companyWebsite': companyWebsite,
    };
  }

  factory CompanyDetails.fromMap(Map<String, dynamic> map) {
    return CompanyDetails(
      companyName: map['companyName'] as String,
      companyShortDescription: map['companyShortDescription'] as String,
      companyLogo: map['companyLogo'] as String,
      companyEmail: map['companyEmail'] as String,
      companyPhone: map['companyPhone'] as String,
      companyWebsite: map['companyWebsite'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyDetails.fromJson(String source) => CompanyDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CompanyDetails(companyName: $companyName, companyShortDescription: $companyShortDescription, companyLogo: $companyLogo, companyEmail: $companyEmail, companyPhone: $companyPhone, companyWebsite: $companyWebsite)';
  }

  @override
  bool operator ==(covariant CompanyDetails other) {
    if (identical(this, other)) return true;

    return other.companyName == companyName && other.companyShortDescription == companyShortDescription && other.companyLogo == companyLogo && other.companyEmail == companyEmail && other.companyPhone == companyPhone && other.companyWebsite == companyWebsite;
  }

  @override
  int get hashCode {
    return companyName.hashCode ^ companyShortDescription.hashCode ^ companyLogo.hashCode ^ companyEmail.hashCode ^ companyPhone.hashCode ^ companyWebsite.hashCode;
  }
}
