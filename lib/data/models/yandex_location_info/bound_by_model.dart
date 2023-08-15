import 'package:google_location/data/models/yandex_location_info/envelope_model.dart';

class BoundedBy {
  final Envelope envelope;

  BoundedBy({
    required this.envelope,
  });

  factory BoundedBy.fromJson(Map<String, dynamic> json) {
    print("ok4");
    return BoundedBy(
      envelope: Envelope.fromJson(json["Envelope"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "Envelope": envelope.toJson(),
      };
}
