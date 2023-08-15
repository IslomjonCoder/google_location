import 'package:google_location/data/models/yandex_location_info/geo_object_model.dart';

class FeatureMember {
  final GeoObject geoObject;

  FeatureMember({
    required this.geoObject,
  });

  factory FeatureMember.fromJson(Map<String, dynamic> json) => FeatureMember(
        geoObject: GeoObject.fromJson(json["GeoObject"]),
      );

  Map<String, dynamic> toJson() => {
        "GeoObject": geoObject.toJson(),
      };
}
