import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/partymembers.dart';




class PartymembersRepository {
  final HttpClient client;
  final int idParty;
 

  PartymembersRepository({
    required this.client,
    required this.idParty, 
   
  });





Future<PartyDetailsMode> getPartymembers() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/partidos/$idParty/membros',
    );

    if (response.statusCode == 200) {
      final bodyDecode = jsonDecode(response.body);
      return PartyDetailsMode.fromMap(bodyDecode['dados']);
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
