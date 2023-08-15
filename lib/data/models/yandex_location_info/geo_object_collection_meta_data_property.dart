import 'package:google_location/data/models/yandex_location_info/geocoder_response_meta_data.dart';

class GeoObjectCollectionMetaDataProperty {
  final GeocoderResponseMetaData geocoderResponseMetaData;

  GeoObjectCollectionMetaDataProperty({
    required this.geocoderResponseMetaData,
  });

  factory GeoObjectCollectionMetaDataProperty.fromJson(
      Map<String, dynamic> json) {
    print("ok8");
    return GeoObjectCollectionMetaDataProperty(
      geocoderResponseMetaData:
          GeocoderResponseMetaData.fromJson(json["GeocoderResponseMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "GeocoderResponseMetaData": geocoderResponseMetaData.toJson(),
      };
}
