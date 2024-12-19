
import 'package:flutter/material.dart';

// Definindo uma classe chamada 'About' que herda de 'StatelessWidget'.
// Essa classe representa uma tela estática (sem estado) do aplicativo.
class About extends StatelessWidget {
  // Construtor da classe 'About'.
  const About({
    super.key,
  });

  // Sobrescrevendo o método 'build' que constrói a interface gráfica.
  @override
  Widget build(BuildContext context) {
    // Definindo uma constante para o título da AppBar.
    const String titleAppBar = 'Sobre';

    // Retornando um widget Scaffold que fornece a estrutura básica de layout.
    return Scaffold(
      // AppBar é a barra de título da aplicação.
      appBar: AppBar(
        centerTitle: true, // Centraliza o título da AppBar.
        title: const Text(
          titleAppBar,
          style: TextStyle(
            color: Colors.white, // Define a cor do texto como branco.
            fontSize: 20, // Define o tamanho da fonte.
            fontWeight: FontWeight.bold, // Define o peso da fonte como negrito.
          ),
        ),
       leading: null, // Remove o botão de voltar (seta) no canto superior esquerdo.

      ),
      // Corpo da tela onde o conteúdo principal é exibido.
      body: SingleChildScrollView(
        // Adiciona um padding (espaçamento interno) ao conteúdo.
        child: Padding(
          padding: const EdgeInsets.all(20),
          // Coluna para organizar os widgets verticalmente.
          child: Column(
            children: [
              // Exibe uma imagem a partir dos assets do projeto.
              Image.asset(
                'assets/images/logo_3.png',
                height: 140, // Define a altura da imagem.
              ),
              // Texto descritivo sobre o aplicativo.
              const Text(
                'Este aplicativo foi desenvolvido como parte do Trabalho de Conclusão de Curso (TCC) no curso de Análise e Desenvolvimento de Sistemas, turma de 2022, do Instituto Federal de Educação, Ciência e Tecnologia de Rondônia (IFRO). O aplicativo tem como objetivo fornecer aos usuários acesso de forma prática e estratégica a informações detalhadas sobre os deputados da Câmara dos Deputados do Brasil. Espera-se que a plataforma contribua para a fiscalização das atividades parlamentares, promovendo uma maior conscientização e senso crítico por parte dos cidadãos, e, assim, auxiliando na formação de um voto mais informado e responsável.'
                ,
                textAlign: TextAlign.center, // Alinha o texto ao centro.
                style: TextStyle(
                  fontSize: 18, // Define o tamanho da fonte.
                ),
              ),
              const SizedBox(height: 20), // Espaçamento entre widgets.
              const Text(
                'Desenvolvido por:',
                style: TextStyle(
                  fontSize: 20, // Define o tamanho da fonte.
                  fontWeight: FontWeight.bold, // Define o peso da fonte como negrito.
                ),
              ),
              const SizedBox(height: 10), // Espaçamento entre widgets.
              
              // Informações sobre os desenvolvedores.
               const Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:  NetworkImage(
                      'https://raw.githubusercontent.com/AmandaSilvaDev/TCC---Intelligence.Gov/refs/heads/main/assets/images/perfil.jpg',
                    ),
                  ),
                  SizedBox(height: 10), // Espaçamento entre widgets.
                  Text(
                    'Amanda da Silva', // Nome do desenvolvedor.
                    style: TextStyle(
                      fontSize: 18, // Define o tamanho da fonte.
                    ),
                  ),
                ],
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
