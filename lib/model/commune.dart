class Commune {
  final int id;
  String? nom;

  Commune({
    required this.id,
    required this.nom,
  });

  Commune.fromJson(Map<String, dynamic> json)
      : id = json['user_id'],
        nom = json['nom'];

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'nom': nom,
      };
}
