import 'package:calculadoras_estatistica/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/drop_down_widget.dart';
import '../widgets/text_widget.dart';
import '../widgets/theme.dart';

class CalculatorTamanhoAmostraProporcaoParamsValueItem {
  final String name;
  final List<CalculatorTamanhoAmostraProporcaoParamsValue> values;
  CalculatorTamanhoAmostraProporcaoParamsValue value;
  String valueDropDown;

  CalculatorTamanhoAmostraProporcaoParamsValueItem(this.name, this.values, this.value, this.valueDropDown);
}

class CalculatorTamanhoAmostraProporcaoParamsValue {
  final String name;
  final double value;

  CalculatorTamanhoAmostraProporcaoParamsValue(this.name, this.value);
}

class CalculatorTamanhoAmostraProporcaoParams {
  double p;
  double erro;
  final CalculatorTamanhoAmostraProporcaoParamsValueItem grauConfianca;
  CalculatorTamanhoAmostraProporcaoParams({
    required this.p,
    required this.erro,
    required this.grauConfianca,
  });
}

class CalculatorTamanhoAmostraProporcao extends StatefulWidget {
  const CalculatorTamanhoAmostraProporcao({super.key});

  @override
  State<CalculatorTamanhoAmostraProporcao> createState() => _CalculatorTamanhoAmostraProporcaoState();
}

class _CalculatorTamanhoAmostraProporcaoState extends State<CalculatorTamanhoAmostraProporcao> {
  late final CalculatorTamanhoAmostraProporcaoParams params;
  late double tamanhoAmostra;
  late double umP;
  late final TextEditingController _controllerP = TextEditingController();
  late final TextEditingController _controllerErro = TextEditingController();

  CalculatorTamanhoAmostraProporcaoParams inicializacao() {
    return CalculatorTamanhoAmostraProporcaoParams(
      p: 0,
      erro: 0,
      grauConfianca: CalculatorTamanhoAmostraProporcaoParamsValueItem(
          "Grau de Confiança",
          [
            CalculatorTamanhoAmostraProporcaoParamsValue("Selecione", 0),
            CalculatorTamanhoAmostraProporcaoParamsValue("90%", 1),
            CalculatorTamanhoAmostraProporcaoParamsValue("95%", 2),
            CalculatorTamanhoAmostraProporcaoParamsValue("99%", 3)
          ],
          CalculatorTamanhoAmostraProporcaoParamsValue("Selecione", 0),
          "Selecione"),
    );
  }

  @override
  void initState() {
    tamanhoAmostra = 0;
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
                  title: "Tamanho da Amostra - Proporção Populacional",
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
                      hintText: '',
                      helperText: '',
                      onChanged: (value) {
                        params.p = double.tryParse(value) ?? 0;
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
                      question: 'Erro (Ep)',
                      controller: _controllerErro,
                      hintText: '',
                      helperText: '',
                      onChanged: (value) {
                        params.erro = double.tryParse(value) ?? 0;
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
                    _value('Tamanho amostra(n): ', tamanhoAmostra.toStringAsFixed(2), Colors.blueGrey),
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

  (double, double) calculatorTamanhoAmostraProporcao(CalculatorTamanhoAmostraProporcaoParams values) {
    throw UnimplementedError();
  }

  void _onChange() {
    final result = calculatorTamanhoAmostraProporcao(params);

    tamanhoAmostra = result.$2;
    umP = result.$1;

    if (!mounted) return;

    setState(() {});
  }
}
