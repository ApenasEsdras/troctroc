import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void mostraSnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(
        mensagem,
      ),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      showCloseIcon: true,
      closeIconColor: const Color.fromRGBO(253, 253, 253, 1),
      duration: const Duration(seconds: 10),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
