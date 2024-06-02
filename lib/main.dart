import 'package:calculadoras_estatistica/routes/route_names.dart';
import 'package:calculadoras_estatistica/routes/router.dart';
import 'package:calculadoras_estatistica/widgets/navigation.dart';
import 'package:flutter/material.dart';

import 'calculators/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRoute,
      title: 'Calculadoras',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: RouteNames.home,
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 229),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ButtonNavigator(
                text: 'Intervalo de Confiança para\na Proporção Populacional',
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.calculadoraIntervaloConfiancaProporcao);
                },
              ),
              const SizedBox(height: 50),
              ButtonNavigator(
                text: 'Intervalo de Confiança para\na Média Populacional',
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.calculadoraIntervaloConfiancaMedia);
                },
              ),
              const SizedBox(height: 50),
              ButtonNavigator(
                text: 'Tamanho da Amostra\nProporção Populacional',
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.calculadoraTamanhoAmostraProporcao);
                },
              ),
              const SizedBox(height: 50),
              ButtonNavigator(
                text: 'Tamanho da Amostra\nMédia Populacional',
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.calculadoraTamanhoAmostraMedia);
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const Calculator();
                          },
                          backgroundColor: Colors.black);
                    },
                    child: const Icon(Icons.calculate),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
