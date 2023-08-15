class Component {
  final String kind;
  final String name;

  Component({
    required this.kind,
    required this.name,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    print("ok5");
    return Component(
      kind: json["kind"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "name": name,
      };
}
