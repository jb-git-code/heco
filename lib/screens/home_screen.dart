import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heco/utils/color_database.dart';
import 'package:heco/utils/new_utils.dart';
import 'package:heco/widgets/color_search_tile.dart';
import '../utils/color_utils.dart';
import '../widgets/color_box.dart';
import '../widgets/palette_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color currentColor = Colors.blue;
  List<Color> palette = [];

  String searchQuery = '';
  List<Color> searchedColors = [];
  List<String> suggestions = [];

  final TextEditingController searchController = TextEditingController();

  // 🔍 SEARCH LOGIC (MaterialColor based)
  void searchColor(String query) {
    final q = query.toLowerCase().trim();

    if (q.isEmpty) {
      setState(() {
        searchedColors = [];
        suggestions = [];
        searchQuery = '';
      });
      return;
    }

    searchQuery = q;

    // Find matching material color names
    suggestions = ColorDatabase.materialColors.keys
        .where((key) => key.contains(q))
        .toList();

    searchedColors = [];

    for (final key in suggestions) {
      searchedColors.addAll(
        ColorUtils.generateMaterialPalette(ColorDatabase.materialColors[key]!),
      );
    }

    setState(() {});
  }

  // 🎲 RANDOM COLOR
  void generateRandomColor() {
    final random = Random();
    setState(() {
      currentColor = Color.fromARGB(
        255,
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
      );
      palette = OldUtils.generateMonochromePalette(currentColor);
    });
  }

  @override
  void initState() {
    super.initState();
    palette = OldUtils.generateMonochromePalette(currentColor);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hex = ColorUtils.toHex(currentColor);
    final rgb = OldUtils.toRGB(currentColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HECO – Color Helper'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 SEARCH BOX
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search color name (e.g. blue)",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: searchColor,
            ),

            const SizedBox(height: 12),

            // 💡 AUTO-SUGGESTIONS
            if (suggestions.isNotEmpty)
              Wrap(
                spacing: 8,
                children: suggestions.map((color) {
                  return ActionChip(
                    label: Text(color),
                    onPressed: () {
                      searchController.text = color;
                      searchColor(color);
                    },
                  );
                }).toList(),
              ),

            const SizedBox(height: 20),

            // 🎨 COLOR PREVIEW
            ColorBox(color: currentColor),

            const SizedBox(height: 20),

            // 🔎 SEARCH RESULTS
            if (searchedColors.isNotEmpty) ...[
              Text(
                "Search Results for \"$searchQuery\"",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchedColors.length,
                itemBuilder: (context, index) {
                  return ColorSearchTile(color: searchedColors[index]);
                },
              ),
            ],

            const SizedBox(height: 20),

            // 🔢 COLOR INFO
            Text(
              "HEX: $hex",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text("RGB: $rgb", style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: generateRandomColor,
              icon: const Icon(Icons.refresh),
              label: const Text("Generate Random Color"),
            ),

            const SizedBox(height: 24),

            // 🎨 MONOCHROME PALETTE
            const Text(
              "Monochrome Palette",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: palette.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  return PaletteRow(color: palette[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
