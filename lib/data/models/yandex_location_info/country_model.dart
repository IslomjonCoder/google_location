import 'package:google_location/data/models/yandex_location_info/administrative_area.dart';

class Country {
  final String addressLine;
  final String countryNameCode;
  final String countryName;
  final AdministrativeArea administrativeArea;

  Country({
    required this.addressLine,
    required this.countryNameCode,
    required this.countryName,
    required this.administrativeArea,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    print("ok6");
    return Country(
      addressLine: json["AddressLine"],
      countryNameCode: json["CountryNameCode"],
      countryName: json["CountryName"],
      administrativeArea:
          AdministrativeArea.fromJson(json["AdministrativeArea"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "AddressLine": addressLine,
        "CountryNameCode": countryNameCode,
        "CountryName": countryName,
        "AdministrativeArea": administrativeArea.toJson(),
      };
}
