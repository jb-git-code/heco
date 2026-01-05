import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_database.dart';
import '../utils/theme_utils.dart';
import '../widgets/theme_preview_card.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ThemeGeneratorScreen extends StatefulWidget {
  const ThemeGeneratorScreen({super.key});

  @override
  State<ThemeGeneratorScreen> createState() => _ThemeGeneratorScreenState();
}

class _ThemeGeneratorScreenState extends State<ThemeGeneratorScreen> {
  List<Color> selectedColors = [];
  bool isDark = false;

  void openColorWheel() {
    Color tempColor = Colors.blue;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final height = MediaQuery.of(context).size.height * 0.75;

        return SafeArea(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Pick a Color",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // 🎯 TRUE CIRCULAR COLOR WHEEL
                  HueRingPicker(
                    pickerColor: tempColor,
                    onColorChanged: (color) {
                      tempColor = color;
                    },
                    enableAlpha: false,
                    displayThumbColor: true,
                  ),

                  const SizedBox(height: 20),

                  // 🎨 Live color preview
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: tempColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Add Color"),
                      onPressed: () {
                        if (selectedColors.length < 4) {
                          setState(() => selectedColors.add(tempColor));
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void toggleColor(Color color) {
    setState(() {
      if (selectedColors.contains(color)) {
        selectedColors.remove(color);
      } else if (selectedColors.length < 4) {
        selectedColors.add(color);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasTheme = selectedColors.length >= 2;
    final generatedTheme = hasTheme
        ? ThemeUtils.buildTheme(selectedColors, isDark: isDark)
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text("Theme Generator"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SwitchListTile(
            //   title: const Text("Dark Theme"),
            //   value: isDark,
            //   onChanged: (value) {
            //     setState(() => isDark = value);
            //   },
            // ),
            // ✅ Selected colors preview
            const Text(
              "Selected Colors (max 4)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 60,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final color = selectedColors.removeAt(oldIndex);
                    selectedColors.insert(newIndex, color);
                  });
                },
                children: [
                  for (int i = 0; i < selectedColors.length; i++)
                    Container(
                      key: ValueKey(selectedColors[i]),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: 50,
                      decoration: BoxDecoration(
                        color: selectedColors[i],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pick Colors from Color-Wheel",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.colorize),
                  tooltip: "Open Color Wheel",
                  onPressed: openColorWheel,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 🎨 Color picker grid
            const Text(
              "Pick Colors",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: ColorDatabase.materialColors.values.map((material) {
                final color = material.shade500;
                final isSelected = selectedColors.contains(color);

                return GestureDetector(
                  onTap: () => toggleColor(color),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.transparent,
                        width: 3,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // 🔮 Theme preview
            if (!hasTheme)
              const Text(
                "Pick at least 2 colors to generate theme",
                style: TextStyle(color: Colors.grey),
              )
            else ...[
              ThemePreviewCard(
                theme: ThemeUtils.buildTheme(selectedColors, isDark: isDark),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.code),
                  label: const Text("Export Theme"),
                  onPressed: () {
                    final code = ThemeUtils.exportFlutterTheme(selectedColors);
                    Clipboard.setData(ClipboardData(text: code));
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
