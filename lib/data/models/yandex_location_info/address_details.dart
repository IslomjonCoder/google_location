import 'package:google_location/data/models/yandex_location_info/country_model.dart';

class AddressDetails {
  final Country country;

  AddressDetails({
    required this.country,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) => AddressDetails(
        country: Country.fromJson(json["Country"]),
      );

  Map<String, dynamic> toJson() => {
        "Country": country.toJson(),
      };
}
