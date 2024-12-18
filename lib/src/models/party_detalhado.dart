class PartyDetailsModel {
  final String? nome;
  final String? sigla;
  final String? idLegislatura;
  final String? totalMembros;
  final String? urlLogo;
  final String? urlFoto;
  final String? nomelider;
  final String? uflider;
  
  final String? memberuf;
  final String? deathDate;
  final String? birthUf;
  final String? birthCity;
  final String? education;
  

  PartyDetailsModel({
    this.nome,
    this.sigla,
    this.idLegislatura,
    this.totalMembros,
    this.urlLogo,
    this.urlFoto,
    this.nomelider,
    this.uflider,
    
    this.memberuf,
    this.deathDate,
    this.birthUf,
    this.birthCity,
    this.education,
    
  });

  factory PartyDetailsModel.fromMap(Map<String, dynamic> map) {
    return PartyDetailsModel(
      nome: map['nome'] ?? '',
      sigla: map['sigla'] ?? '',
      idLegislatura: map['status']['idLegislatura'] ??'',
      totalMembros: map['status']['totalMembros'] ??'' ,
      urlLogo: map['urlLogo'] ?? '',
      urlFoto: map['status']['lider']['urlFoto'] ?? '',
      nomelider: map['status']['lider']['nome'] ?? '',
      uflider: map['status']['lider']['uf'] ?? '',
      
      memberuf: map['dep'] ?? '',
      deathDate: map['dataFalecimento'] ?? '',
      birthUf: map['ufNascimento'] ?? '',
      birthCity: map['municipioNascimento'] ?? '',
      education: map['escolaridade'] ?? '',
      
      
    );
  }
}


