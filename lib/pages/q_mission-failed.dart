import 'package:flutter/material.dart';


class MissionFailedPage extends StatelessWidget {
  const MissionFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, elevation: 0.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  height: 250.0,
                  width: 450.0,
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF001A33).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: const Color(0xFF001A33).withOpacity(0.8),
                        width: 3.0,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'MISSION FAILED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF001A33),
                                side: BorderSide(
                                  color: Colors.blueAccent.withOpacity(0.8),
                                  width: 3.0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                "Main Menu",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF001A33),
                                side: BorderSide(
                                  color: Colors.blueAccent.withOpacity(0.8),
                                  width: 3.0,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                "Buy Lives",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
