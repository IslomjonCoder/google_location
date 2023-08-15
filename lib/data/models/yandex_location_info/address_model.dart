import 'package:google_location/data/models/yandex_location_info/component_model.dart';

class Address {
  final String countryCode;
  final String formatted;
  final List<Component> components;

  Address({
    required this.countryCode,
    required this.formatted,
    required this.components,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    print("ok2");
    return Address(
      countryCode: json["country_code"],
      formatted: json["formatted"],
      components: List<Component>.from(json["Components"].map((x) => Component.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "formatted": formatted,
        "Components": List<dynamic>.from(components.map((x) => x.toJson())),
      };
}
