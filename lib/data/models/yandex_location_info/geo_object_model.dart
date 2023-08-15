import 'package:google_location/data/models/yandex_location_info/bound_by_model.dart';
import 'package:google_location/data/models/yandex_location_info/geo_object_meta_data_property.dart';
import 'package:google_location/data/models/yandex_location_info/point_model.dart';

class GeoObject {
  final GeoObjectMetaDataProperty metaDataProperty;
  final String name;
  final String description;
  final BoundedBy boundedBy;
  final Point point;

  GeoObject({
    required this.metaDataProperty,
    required this.name,
    required this.description,
    required this.boundedBy,
    required this.point,
  });

  factory GeoObject.fromJson(Map<String, dynamic> json) {
    print("ok11");
    return GeoObject(
      metaDataProperty:
          GeoObjectMetaDataProperty.fromJson(json["metaDataProperty"]),
      name: json["name"],
      description: json["description"],
      boundedBy: BoundedBy.fromJson(json["boundedBy"]),
      point: Point.fromJson(json["Point"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "metaDataProperty": metaDataProperty.toJson(),
        "name": name,
        "description": description,
        "boundedBy": boundedBy.toJson(),
        "Point": point.toJson(),
      };
}
