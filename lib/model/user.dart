class User {
  final int id;
  String? nom;
  String token;
  String? compte;
  String? email;
  int? commune;

  User(
      {required this.id,
      required this.nom,
      required this.token,
      required this.email,
      required this.compte,
      this.commune,
      }
  );

  User.fromJson(Map<String, dynamic> json): 
      id = json['user_id'],
      email = json['email'],
      token = json['token'],
      compte = json['compte'],
      nom = json['nom'],
      commune = json['commune_id'];

  Map<String, dynamic> toJson() => {
      'user_id': id,
      'email': email,
      'token': token,
      'nom': nom,
      'compte': compte,
      'commune_id': commune
  };
}
