import 'package:flutter/material.dart';

import 'package:chamber_deputies/src/models/deputados.dart';

class ListDeputiesWidget extends StatefulWidget {
  final List<DeputiesModels> deputies;
  final Function(DeputiesModels) deputyDetailsPage;

  const ListDeputiesWidget({
    super.key,
    required this.deputies,
    required this.deputyDetailsPage,
  });

  @override
  State<ListDeputiesWidget> createState() => _ListDeputiesWidgetState();
}

class _ListDeputiesWidgetState extends State<ListDeputiesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
      scrollDirection: Axis.vertical,
      itemCount: widget.deputies.length,
      itemBuilder: (context, index)
       {
        final deputy = widget.deputies[index];
        return GestureDetector(
          onTap: () => widget.deputyDetailsPage(deputy),
          child: Container(
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
            ), //foto
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(254, 254, 254, 1),
                    borderRadius: BorderRadius.circular(65),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(deputy.urlPhoto),
                  ),
                ),
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
                        deputy.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromRGBO(144, 180, 113, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            color: Color.fromRGBO(144, 180, 113, 1),
                            Icons.location_on,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            deputy.uf,
                            style: const TextStyle(
                              color:Color.fromRGBO(144, 180, 113, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            color: Color.fromRGBO(144, 180, 113, 1),
                            Icons.group,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            deputy.party,
                            style: const TextStyle(
                              color: Color.fromRGBO(144, 180, 113, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
