import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:chamber_deputies/src/screens/home.dart';


// Importa serviços e rotas necessários
import 'package:chamber_deputies/src/services/client.dart';
import 'package:chamber_deputies/src/routes/router.dart';

// Importa modelos, repositórios e stores relacionados aos deputados
import 'package:chamber_deputies/src/models/frentes.dart';
import 'package:chamber_deputies/src/repositories/fronts.dart';
import 'package:chamber_deputies/src/armazena_dados/fronts.dart';

// Define o widget de estado para a tela de Frentes
class Fronts extends StatefulWidget {
  const Fronts({
    super.key,
  });

  @override
  State<Fronts> createState() => _FrontsState();
}


class _FrontsState extends State<Fronts> {
  // Define o título da AppBar como uma constante
  static const String titleAppBar = 'Comissões';
  // Define a página atual para a paginação
  int _pageAtual = 1;

  // Cria uma instância de FrontsStore com o repositório e cliente apropriados
  final FrontsStore store = FrontsStore(
    repository: FrontsRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    // Chama o método para obter os dados das frentes ao iniciar o widget
    store.getFronts();
  }

  // Função para navegar para a página de detalhes de uma frente
  void frontDetailsPage(FrontsModels front) {
    Navigator.pushNamed(
      context,
      arguments: front,
      routesMap['FrontsDetails']!,
    );
  }

  // Função para ir para a página anterior na lista
  void _previousPage() {
    if (_pageAtual > 1) {
      setState(() {
        _pageAtual--;
      });
      store.changePage(_pageAtual);
    }
  }

  // Função para ir para a próxima página na lista
  void _nextPage() {
    if (store.value.value.isNotEmpty) {
      setState(() {
        _pageAtual++;
      });
      store.changePage(_pageAtual);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Configura a AppBar com título e ícone de voltar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          titleAppBar,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),       leading: null, // Remove o botão de voltar (seta) no canto superior esquerdo.

      ),
      body: Column(
        children: [
          // Container que exibe a lista de frentes
          Expanded(
            child: Container(
              color: const Color.fromRGBO(254, 254, 254, 1),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  store.isLoading,
                  store.error,
                  store.value,
                ]),
                builder: (context, _) {
                  // Exibe um indicador de carregamento enquanto os dados estão sendo carregados
                  if (store.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                      ),
                    );
                  }

                  // Exibe uma mensagem de erro se ocorrer um erro
                  if (store.error.value.isNotEmpty) {
                    return Center(
                      child: Text(store.error.value),
                    );
                  }

                  // Exibe uma mensagem se nenhuma frente for encontrada
                  if (store.value.value.isEmpty) {
                    return const Center(
                      child: Text(
                        'Nenhuma comissão encontrada.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  }

                  // Obtém a lista de frentes
                  final fronts = store.value.value;

                  // Exibe a lista de frentes em um ListView
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: fronts.length,
                    itemBuilder: (context, index) {
                      final front = fronts[index];

                      return GestureDetector(
                        onTap: () => frontDetailsPage(front),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(144, 180, 113, 1),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              front.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // Container que exibe os botões de navegação e a página atual

          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(254, 254, 254, 1),
              border: Border(
                top: BorderSide(
                  color:Color.fromRGBO(144, 180, 113, 1),
                  width: 2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botão para a página anterior
                OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(144, 180, 113, 1),
                  ),
                  child: const Text(
                    'Anterior',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                // Exibe o número da página atual
                Text(
                  'Página $_pageAtual',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(144, 180, 113, 1),
                  ),
                ),
                // Botão para a próxima página
                OutlinedButton(
                  onPressed: _nextPage,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(144, 180, 113, 1),
                  ),
                  child: const Text(
                    'Próximo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

