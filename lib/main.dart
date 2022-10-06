import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_boring.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: QuizHome(),
          ),
        ),
      ),
    );
  }
}

class QuizHome extends StatefulWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  State<QuizHome> createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  List<Icon> scoreKeeper = [];
  List<bool> answered = [false, true, true];

  void checkanswered(bool userpickanswered) {
    bool correctanswered = quizBiring.getanswered();
    setState(() {
      if (quizBiring.isFinshed() == true) {
        // Alert package
        Alert(context: context, title: "Done!", desc: "  Question is End  ")
            .show();

        quizBiring.rest();
        scoreKeeper = [];
      } else if (userpickanswered == correctanswered) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quizBiring.nextquestion();
    });
  }

  QuizBiring quizBiring = QuizBiring();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              // center question Text
              child: Text(
                quizBiring.getquestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // button true
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () {
                checkanswered(true);
              },
              child: const Text(
                'ture',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // button false
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              onPressed: () {
                checkanswered(false);
              },
              child: const Text(
                'false',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
        // check and close Icon
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
