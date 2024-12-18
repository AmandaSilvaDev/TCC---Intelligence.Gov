import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Services
import 'package:chamber_deputies/src/services/client.dart';
// Routes
import 'package:chamber_deputies/src/routes/router.dart';
// Models, repositories and stores of deputies
import 'package:chamber_deputies/src/models/deputados.dart';
import 'package:chamber_deputies/src/repositories/deputies.dart';
import 'package:chamber_deputies/src/armazena_dados/deputies.dart';
// Widgets
import 'package:chamber_deputies/src/screens/deputies/widgets/list_deputies_widget.dart';


class Deputies extends StatefulWidget {
  const Deputies({super.key});

  @override
  State<Deputies> createState() => _DeputiesState();
}

class _DeputiesState extends State<Deputies> {
  static const String titleAppBar = 'Deputados';
  final Map<String, String> options = {
    'siglaPartido': 'Partido',
    'siglaUf': 'UF',
    'nome': 'Nome',
  };
  String _selectedOption = '';
  String search = '';

  final DeputiesStore store = DeputiesStore(
    repository: DeputiesRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getDeputies();
  }

  // Navega para a página de detalhes do deputado
  void deputyDetailsPage(DeputiesModels deputy) {
    Navigator.pushNamed(
      context,
      arguments: deputy,
      routesMap['DeputyDetails']!,
    );
  }

  // Define a opção selecionada para o filtro
  void _setSelectedOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  // Filtra a lista de deputados com base na opção selecionada e na busca
  List<DeputiesModels> filterDeputies(List<DeputiesModels> deputies) {
    switch (_selectedOption) {
      case 'siglaPartido':
        return deputies.where((deputy) {
          return deputy.party.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'siglaUf':
        return deputies.where((deputy) {
          return deputy.uf.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'nome':
        return deputies.where((deputy) {
          return deputy.name.toLowerCase().contains(search.toLowerCase());
        }).toList();
      default:
        return deputies;
    }
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
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        backgroundColor: const Color.fromRGBO(144, 180, 113, 1),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedOption.isNotEmpty)
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Pesquisar por ${options[_selectedOption]}',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                    ),
                  ),
                if (_selectedOption.isNotEmpty) const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(144, 180, 113, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_selectedOption.isEmpty)
                        const Text(
                          'Filtrar por:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showCupertinoModalPopup(
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                title: const Text(
                                  'Filtrar por:',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                actions: options.entries
                                    .map(
                                      (entry) => CupertinoActionSheetAction(
                                        onPressed: () {
                                          _setSelectedOption(entry.key);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          entry.value,
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                store.isLoading,
                store.error,
                store.value,
              ]),
              builder: (context, _) {
                if (store.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.amber),
                    ),
                  );
                }

                if (store.error.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      store.error.value,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }

                if (store.value.value.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum deputado encontrado.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final deputies = filterDeputies(store.value.value);

                return ListDeputiesWidget(
                  deputies: deputies,
                  deputyDetailsPage: deputyDetailsPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
