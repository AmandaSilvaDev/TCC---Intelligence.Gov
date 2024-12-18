

import 'package:flutter/material.dart';
import 'package:chamber_deputies/src/repositories/party_detalhes.dart';
import 'package:chamber_deputies/src/models/party.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';

// Repositories and Stores for Deputies Details
import 'package:chamber_deputies/src/armazena_dados/party_detalhes.dart';
import 'package:chamber_deputies/src/screens/fronts_details/informaçoes_partido.dart';
import 'package:chamber_deputies/src/screens/fronts_details/party_lider.dart';




class PartyDetails extends StatefulWidget {
  final Partymodels party;


  const PartyDetails({
    super.key,
    required this.party,
  });

  @override
  State<PartyDetails> createState() => _PartyDetailsState();
}

class _PartyDetailsState extends State<PartyDetails> {
  static const String titleAppBar = 'Detalhes do Partido';
  late PartyDetailsStore storePartyDetails;


  @override
  void initState() {
    super.initState();

    storePartyDetails = PartyDetailsStore(
      repository: PartyDetailsRepository(
        client: HttpClient(),
        idParty: widget.party.id,
        
      ),
    );
    storePartyDetails.getPartyDetails();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          titleAppBar,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromRGBO(254, 254, 254, 1),
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              storePartyDetails.isLoading,
              storePartyDetails.error,
              storePartyDetails.value,
            ],
          ),
          builder: (context, _) {
            if (storePartyDetails.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.amber),
                ),
              );
            }

            if (storePartyDetails.error.value.isNotEmpty) {
              return const Center(
                child: Text(
                  'Erro: Deputado não encontrado!',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (storePartyDetails.value.value.nome == null) {
              return const Center(
                child: Text('Nenhum dado encontrado!'),
              );
            }

            
            final partyDetails = storePartyDetails.value.value;
            

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text( 
                      partyDetails.nome ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InformationPartyWidget(
                      party: widget.party,
                      partyDetails: partyDetails,
                    ),
                    const SizedBox(
                      height: 18,),
                    LiderPartyWidget(
                      party: widget.party, 
                      partyDetails: partyDetails,), 
                                     
        
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
