
// ignore_for_file: deprecated_member_use

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

final expressionProvider = StateProvider<String>((ref) => '');
final resultProvider = StateProvider<String>((ref) => '');
final scientificModeProvider = StateProvider<bool>((ref) => false);

void calculateExpression(WidgetRef ref) {
  final expression = ref.read(expressionProvider);
  try {
    final parsed = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('x²', '^2')
        .replaceAll('√', 'sqrt')
        .replaceAll('π', '${math.pi}')
        .replaceAllMapped(RegExp(r'(sin|cos|tan)(-?\d+(\.\d+)?)'), (match) {
          final func = match[1];
          final value = double.tryParse(match[0] ?? '') ?? 0.0;
          final radians = value * (math.pi / 180);
          switch (func) {
            case 'sin': return math.sin(radians).toString();
            case 'cos': return math.cos(radians).toString();
            case 'tan': return math.tan(radians).toString();
            default: return match[0] ?? '';
          }
        });

    final parser = Parser();
    final exp = parser.parse(parsed);
    final context = ContextModel();

    final eval = exp.evaluate(EvaluationType.REAL, context);
    ref.read(resultProvider.notifier).state = eval.toString();
  } catch (e) {
    ref.read(resultProvider.notifier).state = 'Error';
  }
}
