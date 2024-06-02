import 'package:calculadoras_estatistica/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/theme.dart';
import 'calculator.dart';

class CalculatorIntervaloConfiancaProporcaoParamsValueItem {
  final String name;
  final List<CalculatorIntervaloConfiancaProporcaoParamsValue> values;
  CalculatorIntervaloConfiancaProporcaoParamsValue value;
  String valueDropDown;

  CalculatorIntervaloConfiancaProporcaoParamsValueItem(this.name, this.values, this.value, this.valueDropDown);
}

class CalculatorIntervaloConfiancaProporcaoParamsValue {
  final String name;
  final double value;

  CalculatorIntervaloConfiancaProporcaoParamsValue(this.name, this.value);
}

class CalculatorIntervaloConfiancaProporcaoParams {
  double p;
  double tamanhoAmostra;
  final CalculatorIntervaloConfiancaProporcaoParamsValueItem grauConfianca;
  CalculatorIntervaloConfiancaProporcaoParams({
    required this.p,
    required this.tamanhoAmostra,
    required this.grauConfianca,
  });
}

class CalculatorIntervaloConfiancaProporcao extends StatefulWidget {
  const CalculatorIntervaloConfiancaProporcao({super.key});

  @override
  State<CalculatorIntervaloConfiancaProporcao> createState() => _CalculatorIntervaloConfiancaProporcaoState();
}

class _CalculatorIntervaloConfiancaProporcaoState extends State<CalculatorIntervaloConfiancaProporcao> {
  late final CalculatorIntervaloConfiancaProporcaoParams params;
  late double intervaloConfianca1;
  late double intervaloConfianca2;
  late double erroProporcao;
  late double umP;
  late final TextEditingController _controllerP = TextEditingController();
  late final TextEditingController _controllerTamanhoAmostra = TextEditingController();

  CalculatorIntervaloConfiancaProporcaoParams inicializacao() {
    return CalculatorIntervaloConfiancaProporcaoParams(
      p: 0,
      tamanhoAmostra: 0,
      grauConfianca: CalculatorIntervaloConfiancaProporcaoParamsValueItem(
          "Grau de Confiança",
          [
            CalculatorIntervaloConfiancaProporcaoParamsValue("Selecione", 0),
            CalculatorIntervaloConfiancaProporcaoParamsValue("90%", 1),
            CalculatorIntervaloConfiancaProporcaoParamsValue("95%", 2),
            CalculatorIntervaloConfiancaProporcaoParamsValue("99%", 3)
          ],
          CalculatorIntervaloConfiancaProporcaoParamsValue("Selecione", 0),
          "Selecione"),
    );
  }

  @override
  void initState() {
    intervaloConfianca1 = 0;
    intervaloConfianca2 = 0;
    erroProporcao = 0;
    umP = 0;
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
                  title: "Intervalo de Confiança para a\nProporção Populacional",
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
                    TextFieldCampo(
                      question: 'P',
                      controller: _controllerP,
                      onChanged: (value) {
                        params.p = double.tryParse(value) ?? 0;
                        _onChange();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
                    _value('1 - p: ', umP.toStringAsFixed(2), Colors.blueGrey),
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
                    const SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: _onChange,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                        child: const Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 34),
                    _value('Erro Proporção(Ep): ', erroProporcao.toStringAsFixed(2), Colors.blueGrey),
                    _value('Intervalo de confiança -', intervaloConfianca1.toStringAsFixed(2), Colors.blueGrey),
                    Container(
                      alignment: Alignment.center,
                      child: const Text("< Y <"),
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

  (double, double, double, double) calculatorIntervaloConfiancaProporcao(
      CalculatorIntervaloConfiancaProporcaoParams values) {
    throw UnimplementedError();
  }

  void _onChange() {
    final result = calculatorIntervaloConfiancaProporcao(params);

    umP = result.$1;
    erroProporcao = result.$2;
    intervaloConfianca1 = result.$3;
    intervaloConfianca2 = result.$4;

    if (!mounted) return;

    setState(() {});
  }
}
