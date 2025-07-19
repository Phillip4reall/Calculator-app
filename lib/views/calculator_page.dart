// lib/screens/calculator_screen.dart
import 'package:calculator/services/riverpod.dart';
import 'package:calculator/views/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/calculator_button.dart';

class CalculatorPage extends ConsumerStatefulWidget {
  const CalculatorPage({super.key});

  @override
  ConsumerState<CalculatorPage> createState() => _CalculatorState();
}

class _CalculatorState extends ConsumerState<CalculatorPage> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList('calc_history') ?? [];
    });
  }

  Future<void> _saveHistory(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    history.insert(0, entry);
    await prefs.setStringList('calc_history', history);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final expression = ref.watch(expressionProvider);
    final result = ref.watch(resultProvider);
    final isScientific = ref.watch(scientificModeProvider);

    String formattedResult = result;
    final parsedValue = double.tryParse(result);
    if (parsedValue != null) {
      if (parsedValue.truncateToDouble() == parsedValue) {
        formattedResult = parsedValue.toStringAsFixed(0);
      } else {
        formattedResult = parsedValue.toStringAsFixed(10);
        formattedResult = formattedResult.replaceFirst(RegExp(r'0+\$'), '');
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildModeSwitch(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(expression, style: const TextStyle(color: Colors.white, fontSize: 28)),
                  Text(
                    '= $formattedResult',
                    style: const TextStyle(color: Colors.orange, fontSize: 48),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryPage()));
                    }, child: Text('history',style: TextStyle(fontSize: 18,color: Colors.grey ,fontWeight: FontWeight.w300),)))
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: history.length,
                  //     reverse: true,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  //         child: Text(
                  //           history[index],
                  //           style: const TextStyle(color: Colors.white70),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            const Divider(color: Colors.white24),
            _buildButtons(isScientific),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSwitch() {
    final isScientific = ref.watch(scientificModeProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => ref.read(scientificModeProvider.notifier).state = false,
          child: Text("Basic", style: TextStyle(color: !isScientific ? Colors.orange : Colors.white54)),
        ),
        TextButton(
          onPressed: () => ref.read(scientificModeProvider.notifier).state = true,
          child: Text("Scientific", style: TextStyle(color: isScientific ? Colors.orange : Colors.white54)),
        ),
      ],
    );
  }

  Widget _buildButtons(bool isScientific) {
    final basicButtons = [
      ['7', '8', '9', '÷'],
      ['4', '5', '6', '×'],
      ['1', '2', '3', '-'],
      ['0', '.', '=', '+'],
      ['AC', '(', ')', '⌫'],
    ];

    final scientificButtons = [
      ['sin', 'cos', 'tan', 'log'],
      ['√', 'x²', 'π', '%'],
    ];

    final List<List<String>> buttons = [
      ...isScientific ? scientificButtons : [],
      ...basicButtons
    ];

    return Column(
      children: buttons.map<Widget>((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map<Widget>((btn) {
            return CalculatorButton(label: btn, onTap: () => onButtonTap(btn));
          }).toList(),
        );
      }).toList(),
    );
  }

  void onButtonTap(String btn) {
    final expNotifier = ref.read(expressionProvider.notifier);
    final resNotifier = ref.read(resultProvider.notifier);

    HapticFeedback.lightImpact();

    if (btn == 'AC') {
      expNotifier.state = '';
      resNotifier.state = '';
    } else if (btn == '=') {
      calculateExpression(ref);
      final expression = ref.read(expressionProvider);
      final result = ref.read(resultProvider);
      _saveHistory('$expression = $result');
    } else if (btn == '⌫') {
      expNotifier.state = expNotifier.state.isNotEmpty
          ? expNotifier.state.substring(0, expNotifier.state.length - 1)
          : '';
    } else if (btn == 'π') {
      expNotifier.state += '3.14159265359';
    } else if (btn == 'x²') {
      expNotifier.state += '^2';
    } else if (btn == '√') {
      expNotifier.state += 'sqrt(';  // Ensure function format
    } else if (btn == 'sin' || btn == 'cos' || btn == 'tan' || btn == 'log') {
      expNotifier.state += '$btn(';  // Correct format: sin(
    } else {
      expNotifier.state += btn;
    }
  }
}
