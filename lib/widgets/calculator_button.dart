// import 'package:flutter/material.dart';

// class CalculatorButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;

//   const CalculatorButton({super.key, required this.label, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.all(8),
//         width: 70,
//         height: 70,
//         decoration: BoxDecoration(
//           color: _getButtonColor(label),
//           borderRadius: BorderRadius.circular(35),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 24,
//               color: label == '=' ? Colors.white : Colors.orange,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getButtonColor(String label) {
//     if (label == 'AC' || label == '=' || label == '⌫') return Colors.orange;
//     if ('÷×-+'.contains(label)) return Colors.orangeAccent;
//     return Colors.white10;
//   }
// }

// lib/widgets/calculator_button.dart
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CalculatorButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: _getButtonColor(label),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: _getTextColor(label),
            ),
          ),
        ),
      ),
    );
  }

 Color _getTextColor(String label) {
    if (['=', '+', '-', '×','⌫','AC','÷'].contains(label)) return Colors.white;
    return Colors.orange;
  }
  Color _getButtonColor(String label) {
    if (label == 'AC' || label == '=' || label == '⌫') return Colors.orange;
    if ('÷×-+'.contains(label)) return Colors.orangeAccent;
    return Colors.white10;
  }
}
