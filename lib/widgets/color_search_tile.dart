import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_utils.dart';

class ColorSearchTile extends StatelessWidget {
  final Color color;

  const ColorSearchTile({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final hex = ColorUtils.toHex(color);

    return ListTile(
      leading: CircleAvatar(backgroundColor: color),
      title: Text(hex),
      trailing: const Icon(Icons.copy),
      onTap: () {
        Clipboard.setData(ClipboardData(text: hex));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$hex copied')),
        );
      },
    );
  }
}