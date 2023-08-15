import 'package:google_location/data/models/yandex_location_info/geo_object_collection_model.dart';

class Response {
  final GeoObjectCollection geoObjectCollection;

  Response({
    required this.geoObjectCollection,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    print("ok17");
    return Response(
      geoObjectCollection:
          GeoObjectCollection.fromJson(json["GeoObjectCollection"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "GeoObjectCollection": geoObjectCollection.toJson(),
      };
}
