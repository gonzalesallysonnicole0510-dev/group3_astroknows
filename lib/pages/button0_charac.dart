import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/b-sfx_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

String selectedAstroknowt = 'images/1Avatar.png';
String selectedSpaceship = 'images/rocket1.png';

enum CustomizationType { astroknowt, spaceship }

class CharacCustPage extends StatefulWidget {
  final CustomizationType type;
  const CharacCustPage({super.key, required this.type});

  @override
  State<CharacCustPage> createState() => _CharacCustPageState();
}

class _CharacCustPageState extends State<CharacCustPage> with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  CustomizationType currentType = CustomizationType.astroknowt;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _loadOwnedSpaceships();
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  List<String> ownedSpaceships = [];

  // Load premium spaceship here once bought from shop
  Future<void> _loadOwnedSpaceships() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> saved = prefs.getStringList('ownedSpaceships') ?? [];

    // Include basic spaceship designs
    if (!saved.contains('images/rocket1.png')) {
      saved.insert(0, 'images/rocket1.png');
      saved.insert(1, 'images/rocket2.png');
      saved.insert(2, 'images/rocket3.png');
      saved.insert(3, 'images/rocket4.png');
      saved.insert(4, 'images/rocket5.png');
      saved.insert(5, 'images/rocket6.png');
      saved.insert(6, 'images/rocket7.png');
      saved.insert(7, 'images/rocket8.png');
    }

    setState(() {
      ownedSpaceships = saved;
    });
  }

  Future<void> _saveSelectedSpaceship(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSpaceship', path);
  }

  void _updateAvatar(String avatarPath) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (currentType == CustomizationType.astroknowt) {
        selectedAstroknowt = avatarPath;
        prefs.setString('selectedAstroknowt', avatarPath);
      } else {
        selectedSpaceship = avatarPath;
        prefs.setString('selectedSpaceship', avatarPath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isAvatar = currentType == CustomizationType.astroknowt;
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(10, 10, 26, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('CHARACTER CUSTOMIZATION'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Russo One',
          fontSize: 20,
          letterSpacing: 1.2,
          shadows: [Shadow(blurRadius: 12, color: Colors.cyanAccent)],
        ),
        leading: GestureDetector(
          onTap: () {
            SfxManager.instance.backButton();
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
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.02,
                right: screenWidth * 0.02,
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AstroknowtDesigns(
                      isSelected: isAvatar,
                      onTap: () {
                        setState(() {
                          SfxManager.instance.secButton();
                          currentType = CustomizationType.astroknowt;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    SpaceShipDesigns(
                      isSelected: !isAvatar,
                      onTap: () {
                        setState(() {
                          SfxManager.instance.secButton();
                          currentType = CustomizationType.spaceship;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B1120).withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.cyanAccent.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withValues(alpha: 0.08),
                          blurRadius: 24,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: GridView.count(
                              crossAxisCount: isLandscape ? 4 : 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: (isAvatar
                                      ? [
                                          'images/1Avatar.png',
                                          'images/2Avatar.png',
                                          'images/3Avatar.png',
                                          'images/4Avatar.png',
                                          'images/5Avatar.png',
                                          'images/6Avatar.png',
                                          'images/7Avatar.png',
                                          'images/AvatarAlien.png',
                                        ]
                                      : ownedSpaceships)
                                  .map((path) => _avatarBtn(path))
                                  .toList(),
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          margin: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.03,
                          ),
                          color: Colors.cyanAccent.withValues(alpha: 0.15),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.015),
                            child: AvatarPreview(
                              avatarPath: selectedAstroknowt,
                              spaceshipPath: selectedSpaceship,
                              type: currentType,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarBtn(String path) {
    final bool isSelected = (currentType == CustomizationType.astroknowt)
        ? selectedAstroknowt == path
        : selectedSpaceship == path;

    return GestureDetector(
      onTap: () {
        SfxManager.instance.selection();  // selection sound effect
        _updateAvatar(path);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent.withValues(alpha: 0.12)
              : const Color(0xFF0D1B2A).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? Colors.cyanAccent
                : Colors.cyanAccent.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class AvatarPreview extends StatelessWidget {
  final String avatarPath;
  final String spaceshipPath;
  final CustomizationType type;
  
  const AvatarPreview({
    super.key, 
    required this.avatarPath, 
    required this.spaceshipPath, 
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    final isAvatar = type == CustomizationType.astroknowt;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.cyanAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: const Text(
            'PREVIEW',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontFamily: 'Exo 2',
              fontSize: 11,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 12, color: Colors.cyanAccent)],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF060914).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: isAvatar
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(avatarPath, fit: BoxFit.contain),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        // Increased the rocket height multiplier to 0.95 to make the rocket larger
                        double rocketHeight = constraints.maxHeight * 0.95;

                        return SizedBox(
                          height: rocketHeight,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // ROCKET
                              Image.asset(
                                spaceshipPath,
                                fit: BoxFit.contain,
                              ),
                              // AVATAR BUBBLE 
                              Align(
                                // Adjusted the Y alignment to -0.25 to move the avatar slightly upwards into the rocket window
                                alignment: const Alignment(0.0, -0.25), 
                                child: Container(
                                  // Increased bubble size multiplier to 0.26 to match the larger rocket
                                  width: rocketHeight * 0.26, 
                                  height: rocketHeight * 0.26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.4), 
                                      width: 2
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyanAccent.withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      )
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(avatarPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class AstroknowtDesigns extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  const AstroknowtDesigns({super.key, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.15,
        height: screenHeight * 0.1,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent.withValues(alpha: 0.35) : const Color(0xFF001A33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Image.asset('images/1Avatar.png')),
      ),
    );
  }
}

class SpaceShipDesigns extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  const SpaceShipDesigns({super.key, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.15,
        height: screenHeight * 0.1,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent.withValues(alpha: 0.35) : const Color(0xFF001A33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Image.asset('images/rocket1.png')),
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