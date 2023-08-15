import 'package:google_location/data/models/yandex_location_info/geocoder_meta_data.dart';

class GeoObjectMetaDataProperty {
  final GeocoderMetaData geocoderMetaData;

  GeoObjectMetaDataProperty({
    required this.geocoderMetaData,
  });

  factory GeoObjectMetaDataProperty.fromJson(Map<String, dynamic> json) {
    print("ok10");
    return GeoObjectMetaDataProperty(
      geocoderMetaData: GeocoderMetaData.fromJson(json["GeocoderMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "GeocoderMetaData": geocoderMetaData.toJson(),
      };
}
