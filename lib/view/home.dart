import 'dart:async';

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:want_advice/shared/custom_colors.dart';
import 'package:want_advice/shared/custom_texts.dart';
import 'package:want_advice/view/view_advice.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String adviceExample = "amor";
  TextEditingController _queryController = TextEditingController();
  final translator = GoogleTranslator();

  List<String> listAdviceExample = [
    "amor",
    "vida",
    "filhos",
    "pais",
    "filmes",
    "jogos",
    "horóscopo",
    "pets",
    "casa",
    "viagem",
    "praia",
    "amigos",
    "amor",
  ];

  void newAdviceExample() {
    String nextAdvice = '';
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final index = listAdviceExample.indexOf(adviceExample);

      if (index != -1 && index + 1 < listAdviceExample.length) {
        nextAdvice = listAdviceExample[index + 1];
      }
      setState(() {
        adviceExample = nextAdvice;
      });
    });
  }

  @override
  void initState() {
    newAdviceExample();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(text: 'Quer um', size: 96, color: fontColor),
                  const CustomText(
                      text: 'Conselho?', size: 96, color: fontColor),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 65),
                    child: CustomText(
                      text:
                          'Ganhe um conselho motivacional \n(ou não) a qualquer hora',
                      align: TextAlign.center,
                      size: 28,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: _queryController,
                      decoration: InputDecoration(
                          hintText: "Quero um conselho sobre: $adviceExample",
                          filled: true,
                          fillColor: textFieldBackground,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 250,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: const BorderSide(color: fontColor)))),
                        onPressed: () {
                          final query = _queryController.text.trim();
                          translator
                              .translate(query, from: 'pt', to: 'en')
                              .then((value) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => ShowAdvice(
                                      query: value.toString(),
                                      originalText: query,
                                    ));
                          });
                          _queryController.clear();
                        },
                        child: const CustomText(
                          text: "Quero meu Conselho",
                          color: fontColor,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: const Text(
                      'Vesion 1.0',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
