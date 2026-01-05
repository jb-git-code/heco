import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_utils.dart';

class PaletteRow extends StatelessWidget {
  final Color color;

  const PaletteRow({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final hex = ColorUtils.toHex(color);

    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: hex));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$hex copied')),
        );
      },
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}