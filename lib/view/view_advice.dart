import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:want_advice/api/get_data_api.dart';
import 'package:want_advice/shared/custom_texts.dart';
import 'package:want_advice/shared/snackbar.dart';

class ShowAdvice extends StatefulWidget {
  const ShowAdvice({
    super.key,
    required this.query,
    required this.originalText,
  });

  final String query;
  final String originalText;

  @override
  State<ShowAdvice> createState() => _ShowAdviceState();
}

class _ShowAdviceState extends State<ShowAdvice> {
  String? totalResult;
  String? advice;
  int index = 0;
  final translator = GoogleTranslator();
  List<dynamic>? adviceMap;
  int amountAdvice = 1;
  bool haveAdvice = false;

  void initShowAdvice() async {
    final data = await fetchData(widget.query);

    totalResult = data['total_results'];
    adviceMap = data['slips'];

    try {
      if (adviceMap != null) {
        final adviceInside = adviceMap![index].toString();

        int firstCommaIndex = adviceInside.indexOf('advice:');
        int lastCommaIndex = adviceInside.lastIndexOf(',');

        String resultAdvice =
            adviceInside.substring(firstCommaIndex + 7, lastCommaIndex);

        translator.translate(resultAdvice, from: 'en', to: 'pt').then((value) {
          setState(() {
            haveAdvice = true;
            advice = value.toString();
          });
        });
      } else {
        setState(() {
          advice =
              'Sem conselhos sobre "${widget.originalText}" hoje, tente outro.';
        });
      }
    } catch (e) {
      print('ERROR E: $e');
      showErrorSnackBar(context, title: 'ERRO AO OBTER DADOS DA API');
    }
  }

  Future<void> nextAdvice() async {
    index = index + 1;

    final newAdvice = adviceMap![index].toString();

    int firstCommaIndex = newAdvice.indexOf('advice:');
    int lastCommaIndex = newAdvice.lastIndexOf(',');

    String resultAdvice =
        newAdvice.substring(firstCommaIndex + 7, lastCommaIndex);

    translator.translate(resultAdvice, from: 'en', to: 'pt').then((value) {
      setState(() {
        haveAdvice = true;
        advice = value.toString();
      });
    });
  }

  @override
  void initState() {
    initShowAdvice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (advice == null)
                  const Column(
                    children: [
                      CustomText(
                        text: 'Só mais um segundo...',
                        color: Colors.black,
                        size: 36,
                      ),
                      CustomText(
                        text: 'Estamos buscando os melhores conselhos!',
                        align: TextAlign.center,
                        color: Colors.black,
                        size: 36,
                      ),
                    ],
                  ),
                if (advice != null)
                  Column(
                    children: [
                      CustomText(
                        text: advice ?? '',
                        color: Colors.red,
                        size: 36,
                        align: TextAlign.center,
                      ),
                      if (haveAdvice)
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: '$amountAdvice de $totalResult conselhos',
                                size: 26,
                                color: Colors.black,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    await nextAdvice();

                                    if (amountAdvice <
                                        int.parse(totalResult!)) {
                                      setState(() {
                                        amountAdvice++;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.arrow_forward)),
                            ],
                          ),
                        ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
