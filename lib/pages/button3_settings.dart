import 'package:flutter/material.dart';

int musicLevel = 5;
int sfxLevel = 5;
int narrationLevel = 5;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.lightBlueAccent,
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: screenWidth * 0.7,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1B35),
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
                    fontSize: 23,
                    letterSpacing: 1,
                  ),
                ),
              ),

              VolumeRow(
                title: "Music Volume",
                currentLevel: musicLevel,
                onChanged: (val) => musicLevel = val,
              ),
              const SizedBox(height: 12),
              VolumeRow(
                title: "Sound Effects",
                currentLevel: sfxLevel,
                onChanged: (val) => sfxLevel = val,
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
                              color: Colors.cyanAccent.withOpacity(0.7),
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