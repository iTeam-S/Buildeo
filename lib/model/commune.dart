class Commune {
  final int id;
  String nom;

  Commune({
    required this.id,
    required this.nom,
  });

  Commune.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nom = json['nom'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
      };
  
}
