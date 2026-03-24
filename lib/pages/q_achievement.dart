import 'package:flutter/material.dart';
import 'button2_shop.dart';
import 'title.dart';

class AchievementPage extends StatefulWidget {
  final int star;
  final String planet;
  const AchievementPage({super.key, required this.star, required this.planet});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  late int rewardStar;

  @override
  void initState() {
    super.initState();
    rewardStar = claimedQuizzes.contains(widget.planet) ? 0 : widget.star;
  }

    void claimPoints() {
      if (claimedQuizzes.contains(widget.planet)) return;

    setState(() {
      totalStar += rewardStar;
      claimedQuizzes.add(widget.planet);
      rewardStar = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⭐ 500 Claimed!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1)
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          Row(
            children: [
              // left side of the screen
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.2, right: screenWidth * 0.02, top: screenHeight * 0.05),
                  width: screenWidth * 0.3,
                  height: screenHeight * 1.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/alien.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: null,
                ),
              ),

              // right side of the screen
              Expanded(
                child: Column(
                  children: [
                    // Chat Bubble
                    Container(
                      margin: EdgeInsets.only(left: screenWidth *0.01, right: screenWidth * 0.15, top: screenHeight * 0.08),
                      alignment: Alignment.topCenter,
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 2),
                      ),

                      // Chat Text
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                              '''Congratulations on completing 
the quiz, Astro-knowts!

Take this reward as I have 
prepared for you.''',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      )
                    ),
                    
                    // 500 star points display, when claimed, it will turn into 0
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: screenHeight * 0.08, left: screenWidth * 0.02),
                          width: screenWidth * 0.15,
                          height: screenHeight * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade900,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                              child: FittedBox(
                                  child: Text(
                                  '⭐ $rewardStar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  ),
                                ),
                          ),
                        ),

                        SizedBox(width: 20),

                        Align(
                          alignment: Alignment.center,
                          child: ClaimButton(
                            functionClaim: claimPoints,
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: ExitMainMenu(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class ClaimButton extends StatelessWidget {
  final VoidCallback functionClaim;
  const ClaimButton({super.key, required this.functionClaim});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: functionClaim,

          child: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.08),
            width: screenWidth * 0.15,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade900,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    'Claim',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
            ),
          ),

    );
  }
}



class ExitMainMenu extends StatelessWidget {
  const ExitMainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const TitlePage()),
        );
      },

      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.08, left: screenHeight * 0.01, right: screenWidth * 0.14),
          width: screenWidth * 0.22,
          height: screenHeight * 0.1,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.lightBlue,
              width: 1,
            )
          ),
          child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                  'Main Menu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

              ),
          ),
        ),
      ),
    );
  }
}