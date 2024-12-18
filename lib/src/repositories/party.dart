import 'dart:convert';
import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/party.dart';


class PartyRepository {
  final HttpClient client;

  PartyRepository({
    required this.client,
  });


Future<List<Partymodels>> getparty() async {
    final response = await client.get (
      url: 'https://dadosabertos.camara.leg.br/api/v2/partidos',
    );



    if (response.statusCode == 200) {
      final List<Partymodels> party = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((partis) {
        
        party.add(Partymodels.fromMap(partis));
      }).toList();

      return party;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
   Future<List<Partymodels>> getpartyById(int id) async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/partidos/?$id',
    );

    if (response.statusCode == 200) {
      final List<Partymodels> party = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((partis) {
        partis.add(Partymodels.fromMap(partis));
      }).toList();

      return party;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }

   Future<List<Partymodels>> filterparty(
    String? name,
    String? sigla,
    
    String? urllogo,
    String? uri,
  ) async {
    final dynamic response;
    String url = 'https://dadosabertos.camara.leg.br/api/v2/partidos?';

    url += name != null
        ? 'nome=$name'

        : sigla != null
            ? 'siglaUf=$sigla'
            : uri != null
            ? 'uri=$uri'
            
         
            : '';

                
    
    response = await client.get(url: url);
   
    if (response.statusCode == 200) {
      final List<Partymodels> party = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((partis) {
        partis.add(Partymodels.fromMap(partis));
      }).toList();

      return party;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
    
  }
  Future<List<Partymodels>> filterpartydetalhes(
    String? name,
    String? sigla,
    int? id,
    String? urlPhoto,
  ) async {
    final dynamic response;
    String url = 'https://dadosabertos.camara.leg.br/api/v2/partidos?$id)';

    url += name != null
        ? 'nome=$name'

        : urlPhoto != null
            ? 'urlLogo=$urlPhoto'
            
            : '';

                
    
    response = await client.get(url: url);
   
    if (response.statusCode == 200) {
      final List<Partymodels> party = [];
      final bodyDecode = jsonDecode(response.body);

      bodyDecode['dados'].map((partis) {
        partis.add(Partymodels.fromMap(partis));
      }).toList();

      return party;
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }

   
}