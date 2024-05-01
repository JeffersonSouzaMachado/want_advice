import 'package:flutter/material.dart';
import 'package:want_advice/api/get_data_api.dart';

class ShowAdvice {
  ShowAdvice({
    required this.context,
    required this.query,
  });

  BuildContext context;
  String query;

  void initShowAdvice() async {
    commomDialog(context);
    final data = fetchData(query);

    print(data);
  }

  void commomDialog(BuildContext context) {
    final Widget dialogToShow = Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Conselho',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'montserrat', fontWeight: FontWeight.bold),
                ),
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
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => dialogToShow);
  }
}
