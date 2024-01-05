// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:hangman_game/const/const.dart';
import 'package:hangman_game/game/figure_widget.dart';
import 'package:hangman_game/game/hidden_letters.dart';

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  State<HangmanGame> createState() => _HangmanGameState();
}

class _HangmanGameState extends State<HangmanGame> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  var word = "knife".toUpperCase();
  List<String> selectedChar = [];
  var tries = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Hangman: The Game"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: AppColors().bgColor,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            figure(GameUI.hang, tries >= 0),
                            figure(GameUI.head, tries >= 1),
                            figure(GameUI.body, tries >= 2),
                            figure(GameUI.left_Arm, tries >= 3),
                            figure(GameUI.right_Arm, tries >= 4),
                            figure(GameUI.left_Leg, tries >= 5),
                            figure(GameUI.right_Leg, tries >= 6),
                          ],
                        )),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: word
                            .split("")
                            .map(
                              (e) => hiddenLetters(
                                  e, !selectedChar.contains(e.toUpperCase())),
                            )
                            .toList(),
                      ),
                    ))
                  ],
                )),
            Expanded(
                flex: 1,
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 7,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      children: characters.split("").map((e) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black54,
                            ),
                            onPressed: selectedChar.contains(e.toUpperCase())
                                ? null
                                : () {
                                    setState(() {
                                      selectedChar.add(e.toUpperCase());
                                      if (!word
                                          .split("")
                                          .contains(e.toUpperCase())) {
                                        tries++;
                                      }
                                    });
                                  },
                            child: Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ));
                      }).toList(),
                    )))
          ],
        ));
  }
}
