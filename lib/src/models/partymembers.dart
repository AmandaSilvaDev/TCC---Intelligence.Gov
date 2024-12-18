class PartyDetailsMode {
  final String? nome;
  final String? sigla;
  final String? idLegislatura;
  final String? totalMembros;
  final String? urlLogo;
  final String? urlFoto;
  final String? nomelider;
  final String? uflider;
  
  

  PartyDetailsMode({
    this.nome,
    this.sigla,
    this.idLegislatura,
    this.totalMembros,
    this.urlLogo,
    this.urlFoto,
    this.nomelider,
    this.uflider,
    
    
    
  });

  factory PartyDetailsMode.fromMap(Map<String, dynamic> map) {
    return PartyDetailsMode(
      nome: map['deputado']['nome'] ?? '',
      sigla: map['sigla'] ?? '',
      idLegislatura: map['status']['idLegislatura'] ??'',
      totalMembros: map['status']['totalMembros'] ??'' ,
      urlLogo: map['urlLogo'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      urlFoto: map['status']['lider']['urlFoto'] ?? '',
      nomelider: map['status']['lider']['nome'] ?? '',
      uflider: map['status']['lider']['uf'] ?? '',
      
     
      
    );
  }
}