
import 'dart:ui';

import 'package:flutter/material.dart';

// Models Deputies
import 'package:chamber_deputies/src/models/party.dart';
// Models for Deputy Details
import 'package:chamber_deputies/src/models/party_detalhado.dart';
import 'package:gap/gap.dart';


class InformationPartyWidget extends StatefulWidget {
  final Partymodels party;
  final PartyDetailsModel partyDetails;

  const InformationPartyWidget({
    super.key,
    required this.party,
    required this.partyDetails,
  });

  @override
  State<InformationPartyWidget> createState() =>
      _InformationPartyWidgetState();
}

class _InformationPartyWidgetState extends State<InformationPartyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(254, 254, 254, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                  bottom: 5,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(4, 34, 116, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Informações do Partido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20,left: 2, right: 3, bottom: 20),
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [  
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: 
                      
                     BoxDecoration(
                        image: DecorationImage(image: 
                       NetworkImage(widget.partyDetails.urlLogo as String)
                       
                        ),
                       color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 10)
                      ),
                    ],
                      
                      ),
                    ), //container que contem a logo do partido 
                     const Gap(15),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 2,
                        right: 190,
                        left: 1,
                        bottom: 1),
                     
                   
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sigla do partido:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            (widget.partyDetails.sigla?? ''),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                            const Gap(5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Numero legislatura:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               const Gap(5),
                              Text(
                                widget.partyDetails.idLegislatura?? '' ,
                                
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const Gap(5),
                            ],
                          ),
                          const Text(
                            'Total de deputados',
                            style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                             ),
                          ),
                            const Gap(5),
                           Text( 
                            widget.partyDetails.totalMembros ?? '',
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const Gap(5),
                                              ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        
      ),
      
      
    );
  }
}
