import 'package:flutter/material.dart';

String selectedAstroknowt = 'images/1Avatar.png';
String selectedSpaceship = 'images/spaceship.png';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CharacCustPage(type: CustomizationType.astroknowt),
  ));
}

enum CustomizationType { astroknowt, spaceship }

class CharacCustPage extends StatefulWidget {
  final CustomizationType type;
  const CharacCustPage({super.key, required this.type});

  @override
  State<CharacCustPage> createState() => _CharacCustPageState();
}

class _CharacCustPageState extends State<CharacCustPage> {
  CustomizationType currentType = CustomizationType.astroknowt;

  void _updateAvatar(String avatarPath) {
    setState(() {
      if (currentType == CustomizationType.astroknowt) {
        selectedAstroknowt = avatarPath;
      } else {
        selectedSpaceship = avatarPath;
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
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CHARACTER CUSTOMIZATION:'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Russo One',
          fontSize: 20,
          letterSpacing: 1.2,
        ),

        //back arrow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02, top: screenHeight * 0.02, bottom: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              // Astroknowt look selection
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AstroknowtDesigns(
                  isSelected: isAvatar,
                  onTap: () {
                    setState(() {
                      currentType = CustomizationType.astroknowt;
                    });
                  },
                ),
                const SizedBox(width: 10),

                // Spaceship design seleciton
                SpaceShipDesigns(
                  isSelected: !isAvatar,
                  onTap: () {
                    setState(() {
                      currentType = CustomizationType.spaceship;
                    });
                  },
                ),
              ],
            ),

            // MAIN CONTAINER
            Container(
              width: screenWidth,
              height: screenHeight * 0.65,
              margin: EdgeInsets.only(left: screenWidth * 0.01, right: screenWidth * 0.01),
              padding: EdgeInsets.only(left: screenWidth * 0.02, right: screenWidth * 0.02, top: screenHeight * 0.02, bottom: screenHeight * 0.02),
              decoration: BoxDecoration(
                color: const Color(0xFF001A33),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyanAccent),
              ),
              child: Row(
                children: [
                  // Astro and Spaceship Grid
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      crossAxisCount: isLandscape ? 4 : 3,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: (isAvatar
                      ? [
                        // Astroknowts
                        'images/1Avatar.png',
                        'images/2Avatar.png',
                        'images/3Avatar.png',
                        'images/4Avatar.png',
                        'images/5Avatar.png',
                        'images/6Avatar.png',
                        'images/7Avatar.png',
                        'images/AvatarAlien.png',
                      ]
                      : [
                        // Spaceships
                        'images/spaceship.png',
                        'images/sun.png',
                        'images/premium1.png',
                      ])
                      .map((avatarPath) => _avatarBtn(avatarPath))
                      .toList(),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // PREVIEW
                  Expanded(
                    flex: 1,
                    child: AvatarPreview(
                      avatarPath: selectedAstroknowt,
                      spaceshipPath: selectedSpaceship,
                      type: currentType,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Avatar Choices Button
  Widget _avatarBtn(String fileName) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String path = fileName;

    return GestureDetector(
      onTap: () => _updateAvatar(path),
      child: Container(
        width: screenWidth * 0.08,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedAstroknowt == path
                ? Colors.cyanAccent
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      child: Container(
        width: screenWidth * 0.08,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedSpaceship == path
                ? Colors.cyanAccent
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      ),
      ),
    );
  }
}



class AvatarPreview extends StatelessWidget {
  final String avatarPath;
  final String spaceshipPath;
  final CustomizationType type;
  const AvatarPreview({super.key, required this.avatarPath, required this.spaceshipPath, required this.type});

  @override
  Widget build(BuildContext context) {
    final isAvatar = type == CustomizationType.astroknowt;

    return Column(
      children: [
        Text(
          'PREVIEW',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Russo One',
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.cyanAccent),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: isAvatar

              // Astroknowt only
              ? Image.asset(
                avatarPath,
                fit: BoxFit.contain,
              )

              // Spaceship + Astroknowt
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    // spaceship
                    Image.asset(
                      spaceshipPath,
                      fit: BoxFit.contain,
                    ),

                    // astroknowt
                    Positioned(
                      top: 40,
                      child: Image.asset(
                        avatarPath,
                        width: 40,
                        height: 40,
                      )
                    )
                  ],
            )
            )
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
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent : const Color(0xFF001A33),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Image.asset('images/1Avatar.png')),
      )
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
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent : const Color(0xFF001A33),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Image.asset('images/spaceship.png')),
      )
    );
  }
}