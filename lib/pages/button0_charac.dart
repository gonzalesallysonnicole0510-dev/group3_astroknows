import 'package:flutter/material.dart';

String selectedAvatar = "images/1Avatar.png";

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
  

  void _updateAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
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
               Text(
                'CHARACTER CUSTOMIZATION:',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Russo One',
                    fontSize: 20,
                    letterSpacing: 1.2,
                    ),
              ),
            const SizedBox(height: 20),

            /// MAIN CONTAINER
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
                  /// AVATAR GRID
                  Expanded(
                    flex: 2,
                    child: GridView.count(
                      crossAxisCount: isLandscape ? 4 : 3,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _avatarBtn('images/1Avatar.png'),
                        _avatarBtn('images/2Avatar.png'),
                        _avatarBtn('images/3Avatar.png'),
                        _avatarBtn('images/4Avatar.png'),
                        _avatarBtn('images/5Avatar.png'),
                        _avatarBtn('images/6Avatar.png'),
                        _avatarBtn('images/7Avatar.png'),
                        _avatarBtn('images/AvatarAlien.png'),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  /// PREVIEW
                  Expanded(
                    flex: 1,
                    child: AvatarPreview(
                      avatarPath: selectedAvatar,
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

  /// BUTTON BUILDER
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
            color: selectedAvatar == path
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
    );
  }
}

/// PREVIEW WIDGET
class AvatarPreview extends StatelessWidget {
  final String avatarPath;

  const AvatarPreview({super.key, required this.avatarPath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        FittedBox(
          child: Text("PREVIEW",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Russo One', 
                fontSize: 14,
                letterSpacing: 1.2,
                )),
        ),
        const SizedBox(height: 10),
        Container(
          height: screenHeight * 0.5,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyanAccent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              avatarPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}