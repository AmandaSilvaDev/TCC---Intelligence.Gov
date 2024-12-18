import 'dart:convert';

import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/models/deputado_detalhes.dart';

class DeputyDetailsRepository {
  final HttpClient client;
  final int idDeputy;

  DeputyDetailsRepository({
    required this.client,
    required this.idDeputy,
  });

  Future<DeputyDetailsModel> getDeputyDetails() async {
    final response = await client.get(
      url: 'https://dadosabertos.camara.leg.br/api/v2/deputados/$idDeputy',
    );

    if (response.statusCode == 200) {
      final bodyDecode = jsonDecode(response.body);
      return DeputyDetailsModel.fromMap(bodyDecode['dados']);
    } else if (response.statusCode == 404) {
      throw Exception('Url informada não encontrada!');
    } else {
      throw Exception('Erro: ${response.statusCode}');
    }
  }
}
