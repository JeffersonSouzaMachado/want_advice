import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';


Future<dynamic> showNeutralSnackBar(
    BuildContext context, {
      required String title,
    }) =>
    Flushbar(
      messageText: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
      ),
      icon: const Icon(Icons.check_circle, color: Colors.white, size: 16.0),
      duration: const Duration(seconds: 2),
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.grey[600]!,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      margin: const EdgeInsets.all(8),
    ).show(context);
//  showSnackBar(context, title: title, subtitle: subtitle, backgroundColor: IfoodColors.grayScale600);

Future<dynamic> showSuccessSnackBar(
    BuildContext context, {
      required String title,
    }) =>
    Flushbar(
      messageText: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
      ),
      icon: const Icon(Icons.check_circle, color: Colors.white, size: 16.0),
      duration: const Duration(seconds: 2),
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.green,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      margin: const EdgeInsets.all(8),
    ).show(context);

//   showSnackBar(context, title: title, subtitle: subtitle, icon: const Icon(Icons.check_circle, color: IfoodColors.white), backgroundColor: IfoodColors.positive);

Future<dynamic> showErrorSnackBar(BuildContext context, {required String title, int? duration}) => Flushbar(
  messageText: Text(
    title,
    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
  ),
  icon: const Icon(Icons.error, color: Colors.white, size: 16.0),
  duration: Duration(seconds: duration ?? 2),
  shouldIconPulse: false,
  flushbarPosition: FlushbarPosition.TOP,
  backgroundColor: Colors.red,
  borderRadius: const BorderRadius.all(Radius.circular(15)),
  margin: const EdgeInsets.all(8),
).show(context);

//showSnackBar(context, title: title, subtitle: subtitle, icon: const Icon(Icons.error, color: IfoodColors.white), backgroundColor: IfoodColors.error)

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, {
      Widget? icon,
      String? subtitle,
      required String title,
      required Color backgroundColor,
    }) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Row(
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 15),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );