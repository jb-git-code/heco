import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_utils.dart';

class ColorBox extends StatelessWidget {
  final Color color;

  const ColorBox({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final hex = ColorUtils.toHex(color);

    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hex));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$hex copied to clipboard')),
        );
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Tap to Copy HEX",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 4)],
          ),
        ),
      ),
    );
  }
}