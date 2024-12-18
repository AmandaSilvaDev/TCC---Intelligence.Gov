
import 'package:flutter/material.dart';


import 'package:chamber_deputies/src/models/party.dart';

import 'package:chamber_deputies/src/models/partymembers.dart';



class MembersPartyWidget extends StatefulWidget {
  final Partymodels party;
  final PartyDetailsMode partyDetail;
 

  const MembersPartyWidget({
    super.key,
    required this.party,
    required this.partyDetail,
   
  });

  @override
  State<MembersPartyWidget> createState() =>
      _MembersPartyWidgetState();
}

class _MembersPartyWidgetState extends State<MembersPartyWidget> {
  
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
                      'Membros do Partido',
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
                                                 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color:  Color.fromRGBO(254, 254, 254, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.partyDetail.totalMembros as String,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromRGBO(144, 180, 113, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                      
                    ],
                  ),
                ),
              ],
            ),
                    
          )],
                ),
        ]));
            
       
  }
}
