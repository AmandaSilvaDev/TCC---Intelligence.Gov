
class Partymodels {
  final int id;
  final String uri;
  final String name;
  final String sigla;
  final String uf;
  final String urlPhoto;
  final String email;
  

   Partymodels({
    required this.id,
    required this.uri,
    required this.name,
    required this.sigla,
    required this.uf,
    required this.urlPhoto,
    required this.email,
  });

  factory Partymodels.fromMap(Map<String, dynamic> map) {
    return Partymodels(
      id: map['id'] ?? 0,
      uri: map['uri'] ?? '',
      name: map['nome'] ?? '',
      sigla: map['sigla'] ?? '',
      uf: map['siglaUf'] ?? '',
      urlPhoto: map['urlLogo'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      email: map['email'] ?? '',
    );
  }

 
  
}
