import 'package:calculadoras_estatistica/calculators/calculator_intervalo_confianca_media.dart';
import 'package:calculadoras_estatistica/calculators/tamanho_amostra_proporcao.dart';
import 'package:calculadoras_estatistica/routes/route_names.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../calculators/calculator_intervalo_confianca_proporcao.dart';
import '../calculators/tamanho_amostra_media.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.calculadoraIntervaloConfiancaProporcao:
      return _getPageRoute(const CalculatorIntervaloConfiancaProporcao(), settings);
    case RouteNames.calculadoraIntervaloConfiancaMedia:
      return _getPageRoute(const CalculatorIntervaloConfiancaMedia(), settings);
    case RouteNames.calculadoraTamanhoAmostraMedia:
      return _getPageRoute(const CalculatorTamanhoAmostraMedia(), settings);
    case RouteNames.calculadoraTamanhoAmostraProporcao:
      return _getPageRoute(const CalculatorTamanhoAmostraProporcao(), settings);
  }
  return null;
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  if (kIsWeb) {
    return MaterialPageRoute(builder: (context) => child, settings: settings);
  }

  return FadeRoute(child, settings.name);
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String? routeName;
  FadeRoute(this.child, this.routeName)
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
