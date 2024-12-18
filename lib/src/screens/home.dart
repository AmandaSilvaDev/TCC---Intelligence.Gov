import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chamber_deputies/src/routes/router.dart';
// ignore: unused_import
import 'package:chamber_deputies/src/armazena_dados/party.dart';
import 'package:chamber_deputies/src/models/party.dart';
// ignore: unused_import
import 'package:chamber_deputies/src/repositories/party.dart';
import 'package:chamber_deputies/src/screens/fronts_details/party.dart';
import 'package:chamber_deputies/src/services/client.dart';

class Home extends StatefulWidget {
  const Home({super.key}); // Construtor da classe Home, que é um StatefulWidget.

  @override
  State<Home> createState() => _HomeState(); // Cria o estado para o widget Home.
}

class _HomeState extends State<Home> {
  static const String titleAppBar = 'Início'; // Título fixo da AppBar.
  int _selectedIndex = 0; // Índice do item selecionado na BottomNavigationBar, sempre será 0 visualmente.

  // Função chamada quando um item da BottomNavigationBar é tocado.
  void _onItemTapped(int index) {
    setState(() {
      // Mantenha o índice como 0 visualmente
      _selectedIndex = 0;
    });

    // Navegação direta para a rota correspondente ao índice selecionado.
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, routesMap['Home']!); // Navega para a Home
        break;
      case 1:
        Navigator.pushNamed(context, routesMap['deputados']!); // Navega para Deputados
        break;
      case 2:
        Navigator.pushNamed(context, routesMap['comissoes']!); // Navega para Comissões
        break;
      case 3:
        Navigator.pushNamed(context, routesMap['sobre']!); // Navega para Sobre
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centraliza o título na AppBar.
        title: const Text(
          titleAppBar, // Exibe o título da AppBar.
          style: TextStyle(
            color: Colors.white, // Define a cor do texto como branco.
            fontSize: 20, // Define o tamanho da fonte.
            fontWeight: FontWeight.bold, // Define o peso da fonte como negrito.
          ),
        ),
        automaticallyImplyLeading: false, // Remove a seta de volta da AppBar (caso apareça).
      ),
      body: const Party(), // Corpo da tela, exibindo o widget Party.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.green), // Ícone do item "Início" com cor verde
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.grey), // Ícone do item "Deputados" com cor cinza
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_, color: Colors.grey), // Ícone do item "Comissões" com cor cinza
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color: Colors.grey), // Ícone do item "Sobre" com cor cinza
            label: '',
          ),
        ],
        currentIndex: _selectedIndex, // Índice do item atualmente selecionado, que será sempre 0 visualmente.
        selectedItemColor: Colors.green, // Cor para "Início"
        unselectedItemColor: Colors.grey, // Cor para os outros itens
        backgroundColor: Colors.white, // Cor de fundo da BottomNavigationBar.
        onTap: _onItemTapped, // Função chamada ao tocar em um item.
        iconSize: 28, // Tamanho consistente dos ícones
        selectedFontSize: 14, // Tamanho do texto do item selecionado
        unselectedFontSize: 14, // Tamanho do texto dos itens não selecionados
        showUnselectedLabels: false, // Oculta rótulos não selecionados para manter consistência
      ),
    );
  }
}

// Widget para exibir o conteúdo da tela inicial.
class Party extends StatefulWidget {
  const Party({super.key});

  @override
  State<Party> createState() => _PartyState();
}

class _PartyState extends State<Party> {
  final Map<String, String> options = {
    'siglaPartido': 'Sigla do Partido',
    'nome': 'Nome do Partido',
  };
  String _selectedOption = '';
  String search = '';

  final PartyStore store = PartyStore(
    repository: PartyRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getparty();
  }

  void partyDetailsPage(Partymodels partyDetails) {
    Navigator.pushNamed(
      context,
      arguments: partyDetails,
      routesMap['Party_detalhado']!,
    );
  }

  void _setSelectedOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  List<Partymodels> filterParty(List<Partymodels> party) {
    switch (_selectedOption) {
      case 'siglaPartido':
        return party.where((party) {
          return party.sigla.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'siglaUf':
        return party.where((party) {
          return party.urlPhoto.toLowerCase().contains(search.toLowerCase());
        }).toList();
      case 'nome':
        return party.where((party) {
          return party.name.toLowerCase().contains(search.toLowerCase());
        }).toList();
      default:
        return party;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                  child: Image.asset(
                    'assets/images/logo_3.png', // Imagem exibida na tela inicial.
                    height: 140, // Altura da imagem.
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.all(1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedOption.isEmpty)
                      const Text(
                        'Filtrar por: ',
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
                                  color: Color.fromRGBO(144, 180, 113, 1),
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
                                          color: Color.fromRGBO(144, 180, 113, 1),
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
          const Text(
            'Partidos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(144, 180, 113, 1),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([store.isLoading, store.error, store.value]),
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
                      'Nenhum partido encontrado.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final party = filterParty(store.value.value);

                return ListPartyWidget(
                  party: party,
                  partyDetailsPage: partyDetailsPage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
