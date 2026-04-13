import 'package:flutter/material.dart';
import 'dart:math';
import 'b-sfx_manager.dart';
import 'bg_music.dart';

int musicLevel = 5;
int sfxLevel = 5;
int narrationLevel = 5;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
    late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    BgMusics.instance.setVolume(musicLevel);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 10, 26, 1.0),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 70,
        // back button
        leading: GestureDetector(
          onTap: () {
            SfxManager.instance.backButton(); // sound effect
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0D1B2A),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),

      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _blinkController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarFieldPainter(_blinkController.value),
                size: Size(screenWidth, screenHeight),
              );
            },
          ),
          Center(
            child: Container(
              width: screenWidth * 0.7,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1B35).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.lightBlueAccent,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'SETTINGS',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Russo One',
                        fontSize: 23,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
    
                  VolumeRow(
                    title: "Music Volume",
                    currentLevel: musicLevel,
                    onChanged: (val) {
                      musicLevel = val;
                      BgMusics.instance.setVolume(val);
                    },
                  ),
                  const SizedBox(height: 12),
                  VolumeRow(
                    title: "Sound Effects",
                    currentLevel: sfxLevel,
                    onChanged: (val) {
                      sfxLevel = val;
                      SfxManager.instance.setVolume(val);
                    },
                  ),
                  const SizedBox(height: 12),
                  VolumeRow(
                    title: "Narration",
                    currentLevel: narrationLevel,
                    onChanged: (val) => narrationLevel = val,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

class VolumeRow extends StatefulWidget {
  final String title;
  final int currentLevel;
  final Function(int) onChanged;

  const VolumeRow({
    super.key,
    required this.title,
    required this.currentLevel,
    required this.onChanged,
  });

  @override
  State<VolumeRow> createState() => _VolumeRowState();
}

class _VolumeRowState extends State<VolumeRow> {
  late int level;
  final int maxLevel = 10;

  @override
  void initState() {
    super.initState();
    level = widget.currentLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _circleButton(
              icon: Icons.remove,
              onTap: () {
                setState(() {
                  SfxManager.instance.secButton();
                  if (level > 0) {
                    level--;
                    widget.onChanged(level);
                  }
                });
              },
            ),
            const SizedBox(width: 20),
            Row(
              children: List.generate(maxLevel, (index) {
                bool active = index < level;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 16,
                  height: 10,
                  decoration: BoxDecoration(
                    color: active ? Colors.cyanAccent : Colors.indigo[400],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: Colors.cyanAccent.withValues(alpha: 0.7),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : [],
                  ),
                );
              }),
            ),
            const SizedBox(width: 20),
            _circleButton(
              icon: Icons.add,
              onTap: () {
                setState(() {
                  SfxManager.instance.secButton();
                  if (level < maxLevel) {
                    level++;
                    widget.onChanged(level);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xFF1F2248),
              Color(0xFF15183A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.cyanAccent,
        ),
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  final double blinkValue;
  StarFieldPainter(this.blinkValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Random random = Random(42);
    final paint = Paint();
    for (int i = 0; i < 100; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double starSize = 0.5 + (random.nextDouble() * 2.0);
      double opacity;
      if (i % 3 == 0) {
        opacity = 0.1 + (blinkValue * 0.9);
      } else if (i % 3 == 1) {
        opacity = 1.0 - (blinkValue * 0.9);
      } else {
        opacity = 0.4;
      }
      paint.color = Colors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarFieldPainter oldDelegate) =>
      oldDelegate.blinkValue != blinkValue;
}