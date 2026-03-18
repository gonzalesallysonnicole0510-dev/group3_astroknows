import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CharacCustPage(),
  ));
}

class CharacCustPage extends StatefulWidget {
  const CharacCustPage({super.key});

  @override
  State<CharacCustPage> createState() => _CharacCustPageState();
}

class _CharacCustPageState extends State<CharacCustPage> {
  // Current state of the rocket color
  Color selectedRocketColor = const Color(0xFF4A8FFF);

  void _updateColor(Color newColor) {
    setState(() {
      selectedRocketColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CHARACTER CUSTOMIZATION:',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              // The Stack allows the Back Button to sit on top of the container
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001A33).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.cyanAccent.withOpacity(0.9),
                        width: 3.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyan.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0), // Space for back button
                            child: GridView.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SelectionButton(
                                  iconData: Icons.palette,
                                  text: 'CYAN',
                                  color: Colors.cyan,
                                  onTap: () => _updateColor(Colors.cyan),
                                ),
                                SelectionButton(
                                  iconData: Icons.palette,
                                  text: 'ORANGE',
                                  color: Colors.orange,
                                  onTap: () => _updateColor(Colors.orange),
                                ),
                                SelectionButton(
                                  iconData: Icons.palette,
                                  text: 'PURPLE',
                                  color: Colors.purpleAccent,
                                  onTap: () => _updateColor(Colors.purpleAccent),
                                ),
                                SelectionButton(
                                  iconData: Icons.palette,
                                  text: 'LIME',
                                  color: Colors.limeAccent,
                                  onTap: () => _updateColor(Colors.limeAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                            child: CompositedRocketPreview(rocketColor: selectedRocketColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Corrected Back Button placement inside the Stack
                  Positioned(
                    top: 15.0,
                    left: 15.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                      ),
                    ),
  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final VoidCallback onTap;

  const SelectionButton({
    super.key,
    required this.iconData,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        side: BorderSide(color: color, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 20, color: color),
          Text(text, style: const TextStyle(fontSize: 9, color: Colors.white)),
        ],
      ),
    );
  }
}

class CompositedRocketPreview extends StatelessWidget {
  final Color rocketColor;
  const CompositedRocketPreview({super.key, required this.rocketColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 20,
            child: Row(
              children: [
                _buildFin(true),
                const SizedBox(width: 40),
                _buildFin(false),
              ],
            ),
          ),
          Positioned(
            top: 40,
            child: Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                color: rocketColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              width: 50,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF2C3E50),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
            ),
          ),
          Positioned(
            top: 60,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
              child: const Icon(Icons.person, size: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFin(bool left) {
    return Container(
      width: 20,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.only(
          bottomLeft: left ? const Radius.circular(20) : Radius.zero,
          bottomRight: left ? Radius.zero : const Radius.circular(20),
        ),
      ),
    );
  }
}