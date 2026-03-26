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
  String selectedAvatar = "images/Avatar1.png";

  void _updateAvatar(String avatarPath) {
    setState(() {
      selectedAvatar = avatarPath;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CHARACTER CUSTOMIZATION:',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            /// MAIN CONTAINER
            Container(
              padding: const EdgeInsets.all(20),
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
                        _avatarBtn('images/Avatar1.png'),
                        _avatarBtn('images/Avatar2.png'),
                        _avatarBtn('images/Avatar3.png'),
                        _avatarBtn('images/Avatar4.png'),
                        _avatarBtn('images/Avatar5.png'),
                        _avatarBtn('images/Avatar6.png'),
                        _avatarBtn('images/Avatar7.png'),
                        _avatarBtn('images/AlienAvatar.png'),
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
    String path = "images/$fileName";

    return GestureDetector(
      onTap: () => _updateAvatar(path),
      child: Container(
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
          child: Image.asset(path, fit: BoxFit.cover),
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
    return Column(
      children: [
        const Text("PREVIEW",
            style: TextStyle(color: Colors.white, fontSize: 14)),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.cyanAccent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(
              avatarPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}