import 'package:flutter/material.dart';

class ThemePreviewCard extends StatelessWidget {
  final ThemeData theme;

  const ThemePreviewCard({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    return Theme(
      data: theme,
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.primary.withOpacity(0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🔵 PRIMARY
              Container(
                height: 56,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: scheme.primary,
                child: Text(
                  "Primary AppBar",
                  style: TextStyle(
                    color: scheme.onPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // ⚪ BACKGROUND
              Container(
                color: scheme.background,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRIMARY BUTTON
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Primary Button"),
                    ),

                    const SizedBox(height: 10),

                    // SECONDARY BUTTON
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("Secondary Button"),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Background text preview",
                      style: TextStyle(color: scheme.onBackground),
                    ),

                    const SizedBox(height: 12),

                    // 🟣 SURFACE (4th color)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Surface / Accent Card (4th color)",
                        style: TextStyle(color: scheme.onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}