import 'package:google_location/data/models/yandex_location_info/bound_by_model.dart';
import 'package:google_location/data/models/yandex_location_info/point_model.dart';

class GeocoderResponseMetaData {
  final Point point;
  final BoundedBy boundedBy;
  final String request;
  final String results;
  final String found;

  GeocoderResponseMetaData({
    required this.point,
    required this.boundedBy,
    required this.request,
    required this.results,
    required this.found,
  });

  factory GeocoderResponseMetaData.fromJson(Map<String, dynamic> json) {
    print("ok13");
    return GeocoderResponseMetaData(
      point: Point.fromJson(json["Point"]),
      boundedBy: BoundedBy.fromJson(json["boundedBy"]),
      request: json["request"],
      results: json["results"],
      found: json["found"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Point": point.toJson(),
        "boundedBy": boundedBy.toJson(),
        "request": request,
        "results": results,
        "found": found,
      };
}
