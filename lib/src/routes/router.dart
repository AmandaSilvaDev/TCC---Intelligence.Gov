import 'package:chamber_deputies/src/models/party.dart';
import 'package:chamber_deputies/src/screens/fronts_details/party_detalhado.dart';
import 'package:flutter/material.dart';

// Home
import 'package:chamber_deputies/src/screens/home.dart';
// Deputies
import 'package:chamber_deputies/src/models/deputados.dart';
import 'package:chamber_deputies/src/screens/deputy_details/deputy_details.dart';
import 'package:chamber_deputies/src/screens/deputies/deputados.dart';
// Fronts
import 'package:chamber_deputies/src/models/frentes.dart';
import 'package:chamber_deputies/src/screens/comissoes.dart';
import 'package:chamber_deputies/src/screens/fronts_details/front_details.dart';

// About
import 'package:chamber_deputies/src/screens/sobre.dart';

Map<String, String> routesMap = {
  'Home': '/home',
  'Party_detalhado': '/party_detalhado',
  'deputados': '/deputados',
  'DeputyDetails': '/deputy-details',
  'comissoes': '/comissoes',
  'FrontsDetails': '/fronts-details',
  'sobre': '/sobre',
};

Route browserRouter(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(
        builder: (context) => const Home(),
      );
    
    case '/party_detalhado':
      return MaterialPageRoute(
        builder: (context) => PartyDetails(
          party: settings.arguments as Partymodels,
        ),

      );

    case '/deputados':
      return MaterialPageRoute(
        builder: (context) => const Deputies(),
      );

    case '/deputy-details':
      return MaterialPageRoute(
        builder: (context) => DeputyDetails(
          deputy: settings.arguments as DeputiesModels,
        ),
      );

    case '/comissoes':
      return MaterialPageRoute(
        builder: (context) => const Fronts(),
      );

    case '/fronts-details':
      return MaterialPageRoute(
        builder: (context) => FrontDetails(
          front: settings.arguments as FrontsModels,
        ),
      );

    case '/sobre':
      return MaterialPageRoute(
        builder: (context) => const About(),
      );

    default:
      return MaterialPageRoute(builder: (context) => const Home());
  }
}
