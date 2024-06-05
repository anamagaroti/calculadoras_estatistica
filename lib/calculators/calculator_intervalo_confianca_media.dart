import 'dart:math';

import 'package:calculadoras_estatistica/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/theme.dart';
import 'calculator.dart';

class CalculatorIntervaloConfiancaMediaParamsValueItem {
  final String name;
  final List<CalculatorIntervaloConfiancaMediaParamsValue> values;
  CalculatorIntervaloConfiancaMediaParamsValue value;
  String valueDropDown;

  CalculatorIntervaloConfiancaMediaParamsValueItem(this.name, this.values, this.value, this.valueDropDown);
}

class CalculatorIntervaloConfiancaMediaParamsValue {
  final String name;
  final double value;

  CalculatorIntervaloConfiancaMediaParamsValue(this.name, this.value);
}

class CalculatorIntervaloConfiancaMediaParams {
  double media;
  double desvioPadrao;
  double tamanhoAmostra;
  final CalculatorIntervaloConfiancaMediaParamsValueItem grauConfianca;
  CalculatorIntervaloConfiancaMediaParams({
    required this.media,
    required this.desvioPadrao,
    required this.tamanhoAmostra,
    required this.grauConfianca,
  });
}

class CalculatorIntervaloConfiancaMedia extends StatefulWidget {
  const CalculatorIntervaloConfiancaMedia({super.key});

  @override
  State<CalculatorIntervaloConfiancaMedia> createState() => _CalculatorIntervaloConfiancaMediaState();
}

class _CalculatorIntervaloConfiancaMediaState extends State<CalculatorIntervaloConfiancaMedia> {
  late final CalculatorIntervaloConfiancaMediaParams params;
  late double intervaloConfianca1;
  late double intervaloConfianca2;
  late double erroMedia;
  late double alfa;
  late final TextEditingController _controllerMedia = TextEditingController();
  late final TextEditingController _controllerDesvioPadrao = TextEditingController();
  late final TextEditingController _controllerTamanhoAmostra = TextEditingController();

  CalculatorIntervaloConfiancaMediaParams inicializacao() {
    return CalculatorIntervaloConfiancaMediaParams(
      media: 0,
      desvioPadrao: 0,
      tamanhoAmostra: 0,
      grauConfianca: CalculatorIntervaloConfiancaMediaParamsValueItem(
          "Grau de Confiança",
          [
            CalculatorIntervaloConfiancaMediaParamsValue("Selecione", 0),
            CalculatorIntervaloConfiancaMediaParamsValue("90%", 1),
            CalculatorIntervaloConfiancaMediaParamsValue("95%", 2),
            CalculatorIntervaloConfiancaMediaParamsValue("99%", 3)
          ],
          CalculatorIntervaloConfiancaMediaParamsValue("Selecione", 0),
          "Selecione"),
    );
  }

  @override
  void initState() {
    intervaloConfianca1 = 0;
    intervaloConfianca2 = 0;
    erroMedia = 0;
    alfa = 0;
    params = inicializacao();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final grauConfiancaNames = params.grauConfianca.values.map((e) => e.name).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                AppBarWidget(
                  title: "Intervalo de Confiança para a\nMédia Populacional",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
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
                    TextFieldCampo(
                      question: 'Média',
                      controller: _controllerMedia,
                      onChanged: (value) {
                        params.media = double.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    _contentDropDown(
                      params.grauConfianca.name,
                      grauConfiancaNames,
                      params.grauConfianca.valueDropDown,
                      (value) {
                        final indexElement = grauConfiancaNames.indexOf(value as String);
                        if (!mounted) return;
                        setState(() {
                          params.grauConfianca.value = params.grauConfianca.values[indexElement];
                          params.grauConfianca.valueDropDown = value;
                        });
                      },
                    ),
                    _value('alfa(a): ', alfa.toString(), Colors.blueGrey),
                    TextFieldCampo(
                      question: 'Desvio Padrão',
                      controller: _controllerDesvioPadrao,
                      onChanged: (value) {
                        params.desvioPadrao = double.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    TextFieldCampo(
                      question: 'Tamanho da Amostra (n)',
                      controller: _controllerTamanhoAmostra,
                      onChanged: (value) {
                        params.tamanhoAmostra = double.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _onChange,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                        child: const Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    _value('Erro Média(Em): ', erroMedia.toStringAsFixed(2), Colors.blueGrey),
                    _value('Intervalo de confiança -', intervaloConfianca1.toStringAsFixed(2), Colors.blueGrey),
                    Container(
                      alignment: Alignment.center,
                      child: const Text("<    μ    <"),
                    ),
                    _value('Intervalo de confiança +', intervaloConfianca2.toStringAsFixed(2), Colors.blueGrey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentDropDown(String title, List<String> names, String value, Function(Object?) onChanged) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            textStyleNum: TextStyleNum.headline1,
            text: title,
            fontWeightNum: FontWeightNum.w600,
          ),
          const SizedBox(
            height: 8,
          ),
          DropDownWidget(
            list: names,
            onChanged: (value) {
              onChanged(value);
              _onChange();
            },
            validator: (value) {
              return null;
            },
            value: value,
          ),
        ],
      ),
    );
  }

  Widget _value(String text, String value, Color color) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              TextWidget(
                textStyleNum: TextStyleNum.headline1,
                text: text,
                fontWeightNum: FontWeightNum.w500,
              ),
            ],
          ),
          TextWidget(
            textStyleNum: TextStyleNum.headline3,
            text: value,
            fontWeightNum: FontWeightNum.w700,
            headlineColor: color,
          ),
        ],
      ),
    );
  }

  (double, double, double, double) calculatorIntervaloConfiancaMedia(CalculatorIntervaloConfiancaMediaParams values) {
    double alfa = 0;

    final media = values.media;
    final desvioPadrao = values.desvioPadrao;
    final tamanhoAmostra = values.tamanhoAmostra;
    final grauConfianca = values.grauConfianca.value.value;

    if (grauConfianca == 1) alfa = 1.645;
    if (grauConfianca == 2) alfa = 1.96;
    if (grauConfianca == 3) alfa = 2.575;

    double quadrada = sqrt(tamanhoAmostra);
    double erroMedia = alfa * (desvioPadrao / quadrada);

    double intervaloConfianca1 = media - erroMedia;
    double intervaloConfianca2 = media + erroMedia;

    if (alfa.isNaN) alfa = 0;
    if (erroMedia.isNaN) erroMedia = 0;
    if (intervaloConfianca2.isNaN) intervaloConfianca2 = 0;
    if (intervaloConfianca1.isNaN) intervaloConfianca1 = 0;

    return (alfa, erroMedia, intervaloConfianca1, intervaloConfianca2);
  }

  void _onChange() {
    final result = calculatorIntervaloConfiancaMedia(params);

    alfa = result.$1;
    erroMedia = result.$2;
    intervaloConfianca1 = result.$3;
    intervaloConfianca2 = result.$4;

    if (!mounted) return;

    setState(() {});
  }
}
