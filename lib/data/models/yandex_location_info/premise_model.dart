class Premise {
  final String premiseNumber;

  Premise({
    required this.premiseNumber,
  });

  factory Premise.fromJson(Map<String, dynamic> json) {
    print("ok16");
    return Premise(
      premiseNumber: json["PremiseNumber"],
    );
  }

  Map<String, dynamic> toJson() => {
        "PremiseNumber": premiseNumber,
      };
}
