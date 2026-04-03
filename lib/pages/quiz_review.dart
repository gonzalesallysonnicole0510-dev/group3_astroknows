import 'package:flutter/material.dart';

import 'quiz_QnA.dart';

class Quiz_Review extends StatelessWidget {
  final List<Map<String, dynamic>> quiz;
  final String planet;

  const Quiz_Review({super.key, required this.quiz, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('${planet[0].toUpperCase()}${planet.substring(1).toLowerCase()} Review'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Michroma',
          letterSpacing: 1,
        ),
       
        // back arrow
        leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.white),
         onPressed: () => Navigator.pop(context),
        ),
      ),

      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index) {
          final question = quiz[index]['question'];
          final answers = quiz[index]['answers'];
          final correctIndex = quiz[index]['correct'];

          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Color(0xFF0D1925), Color(0xFF040B14)],
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.lightBlue,
              )
            ),
            margin: EdgeInsets.only(top: 10, bottom: 20, left: 80, right: 80),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Question
                  Text(
                    '$question',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Share Tech',
                      height: 2.7,
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(answers.length, (i) {
                      return Text(
                        answers[i] + ' ',
                        style: TextStyle(
                          fontFamily: 'Share Tech',
                          color: i == correctIndex
                              ? Colors.green
                              : Colors.white,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}